import 'dart:async';
import 'dart:ui';

import 'package:kazi/core/constants/storage_keys.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/services/data/analytics/friction_detector.dart';
import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/core/services/domain/analytics_service.dart';
import 'package:kazi/core/services/domain/time_service.dart';
import 'package:kazi/core/utils/base_notifier.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/clients/domain/models/record_counters.dart';
import 'package:kazi/features/clients/domain/repositories/clients_repository.dart';
import 'package:kazi/features/clients/domain/services/client_document_rule.dart';
import 'package:kazi/features/clients/domain/services/client_namesake_rule.dart';
import 'package:kazi/features/clients/presenter/controllers/clients_controller.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/subscription/domain/freemium_gate.dart';
import 'package:kazi/features/subscription/domain/freemium_guard.dart';
import 'package:kazi/features/subscription/presenter/controllers/paywall_prompt_controller.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import 'service_form_state.dart';

part 'service_form_controller.g.dart';

/// A client already carrying the name being typed, and the figure that makes
/// the person recognizable. [serviceCount] is null when nothing could say —
/// never zero for "unknown".
typedef ClientNamesake = ({ClientEntry client, int? serviceCount});

@riverpod
class ServiceFormController extends _$ServiceFormController
    with BaseAsyncNotifier<ServiceFormState> {
  ServicesRepository get _servicesRepository =>
      ref.read(servicesRepositoryProvider);

  CatalogItemRepository get _catalogItemRepository =>
      ref.read(catalogItemRepositoryProvider);

  AuthService get _authService => ref.read(authServiceProvider);

  ClientsRepository get _clientsRepository =>
      ref.read(clientsRepositoryProvider);

  FreemiumGuard get _freemiumGuard => ref.read(freemiumGuardProvider);

  SupportedCurrency get _defaultCurrency =>
      ref.read(kaziDefaultCurrencyProvider);

  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);

  void _promptPaywall(LimitType limit) {
    unawaited(
      _analytics.log(
        AnalyticsEvent.limitReached,
        parameters: {'limit_type': limit.name, 'form': _formName},
      ),
    );
    ref.read(paywallPromptControllerProvider.notifier).promptFor(limit);
  }

  // Abandonment tracking

  static const String _formName = 'service';

  DateTime? _openedAt;
  final Set<String> _touchedFields = {};
  String? _lastField;
  bool _didCreate = false;
  bool _hadValidationError = false;

  /// Resolved in [build] because Riverpod forbids touching `Ref` inside an
  /// `onDispose` callback — and disposal is the only moment that can tell the
  /// form was left rather than submitted.
  AnalyticsService? _capturedAnalytics;
  FrictionDetector? _capturedFriction;
  TimeService? _capturedTime;

  /// The field people stop on is the one asking for something they do not have
  /// to hand.
  void _touch(String field) {
    _touchedFields.add(field);
    _lastField = field;
  }

  /// Hung off `onDispose` rather than a back button: the form can be left by
  /// the back gesture, a tab switch or the router, and only disposal sees all
  /// three.
  void _reportAbandonment() {
    final openedAt = _openedAt;
    final analytics = _capturedAnalytics;
    final time = _capturedTime;
    if (openedAt == null || analytics == null || time == null) return;
    if (_didCreate) return;
    // Untouched means a misdirected tap, not an abandonment.
    if (_touchedFields.isEmpty) return;

    final elapsed = time.now.difference(openedAt);

    unawaited(
      analytics.log(
        AnalyticsEvent.serviceFormAbandoned,
        parameters: {
          'seconds': elapsed.inSeconds,
          'filled_fields': _touchedFields.length,
          'had_validation_error': _hadValidationError,
          if (_lastField case final String field) 'last_field': field,
        },
      ),
    );

    _capturedFriction?.onFormAbandoned(
      form: _formName,
      elapsed: elapsed,
      screen: AppPage.addServices.name,
    );
  }

  Future<ExchangeRateHistoryService> get _rateHistory =>
      ref.read(exchangeRateHistoryServiceProvider.future);

  @override
  FutureOr<ServiceFormState> build({Service? service}) async {
    // Only a creation is measured: leaving an edit alone is normal, leaving a
    // new service unsaved is the thing that needs explaining.
    if (service == null) {
      _capturedTime = ref.read(timeServiceProvider);
      _capturedAnalytics = _analytics;
      _capturedFriction = ref.read(frictionDetectorProvider);
      _openedAt = _capturedTime!.now;
      unawaited(_capturedAnalytics!.log(AnalyticsEvent.serviceFormOpened));
      ref.onDispose(_reportAbandonment);
    }

    try {
      final userId = _authService.user!.uid;
      final items = await _getCatalogItems(userId);
      final clients = await _getClients(userId);
      final archivedClients = await _getArchivedClients(userId);

      // The form always renders (never an empty state): a user with no service
      // items or clients can create them inline via the quick-add sheets.
      return ServiceFormState(
        status: BaseStateStatus.readyToUserInput,
        userId: userId,
        catalogItems: items,
        clients: clients,
        archivedClients: archivedClients,
        service: service,
      );
    } on AppError catch (exception) {
      final userId = _authService.user?.uid ?? '';
      return ServiceFormState(
        status: BaseStateStatus.error,
        callbackMessage: exception.message,
        userId: userId,
        service: service,
      );
    } catch (exception) {
      final userId = _authService.user?.uid ?? '';
      return ServiceFormState(
        status: BaseStateStatus.error,
        callbackMessage: KaziLocalizations.current.errorUnknowError,
        userId: userId,
        service: service,
      );
    }
  }

  Service _withDefaultCurrency(Service service) => service.currency.isEmpty
      ? service.copyWith(currency: _defaultCurrency.isoCode)
      : service;

  /// Stamps the currency and the rate snapshot the value is anchored to.
  ///
  /// The anchor follows the service's own date, not the moment it was typed in,
  /// so backdating a service converts with the rate that actually applied then.
  /// It is recomputed on every save because an edit can change either the date
  /// or the currency.
  Future<Service> _withRateAnchor(Service service) async {
    final withCurrency = _withDefaultCurrency(service);

    try {
      final history = await _rateHistory;
      return withCurrency.copyWith(
        rateDate: await history.resolveDateKey(withCurrency.date),
      );
    } catch (_) {
      // Offline: record the service's own day, which resolves once the shared
      // history covers it.
      return withCurrency.copyWith(
        rateDate: ExchangeRates.dateKeyOf(withCurrency.date),
      );
    }
  }

  Future<List<CatalogItem>> _getCatalogItems(String userId) async {
    final result = await _catalogItemRepository.get(userId);
    return result;
  }

  Future<List<ClientEntry>> _getClients(String userId) async {
    return _clientsRepository.getClients(userId, limit: 100);
  }

  /// Loaded so a service whose client was archived still shows that client's
  /// name; they are never offered as options. A failure here costs the label,
  /// not the form.
  Future<List<ClientEntry>> _getArchivedClients(String userId) async {
    try {
      return await _clientsRepository.getArchivedClients(userId, limit: 100);
    } catch (_) {
      return const [];
    }
  }

  void onChangeClient(DropdownItem? dropdownItem) {
    _touch('client');
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(
        // Null means the user hit the picker's clear button. It needs the
        // explicit unlink, because `copyWith` cannot write a null.
        service: dropdownItem == null
            ? current.service.withoutClient()
            : current.service.copyWith(
                clientId: dropdownItem.value,
                // Denormalize the name so the service keeps a historical
                // snapshot of who it was performed for (see
                // [Service.clientName]).
                clientName: dropdownItem.label,
              ),
      ),
    );
  }

  Future<void> quickAddCatalogItem({
    required String name,
    double? defaultValue,
    double? commissionPercent,
    SupportedCurrency? currency,
    Color? color,
  }) async {
    final current = state.asData?.value;
    if (current == null) return;

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ClientError(
        KaziLocalizations.current.requiredProperty(
          KaziLocalizations.current.catalogItem,
        ),
      );
    }
    // Compared normalized, and against the archived items too: a second row
    // under the same name would split one total in two, and the archive screen
    // is where the original is brought back from.
    final normalized = trimmedName.normalizedName;
    if (current.catalogItems.any(
      (item) => item.name.normalizedName == normalized,
    )) {
      throw ClientError(
        KaziLocalizations.current.alreadyExists(
          KaziLocalizations.current.catalogItem,
        ),
      );
    }

    final gate = await _freemiumGuard.checkAddCatalogItem(
      current.catalogItems.length,
    );
    if (gate.isBlocked) {
      _promptPaywall(gate.blockedBy!);
      return;
    }

    final created = await _catalogItemRepository.add(
      CatalogItem(
        userId: current.userId,
        name: trimmedName,
        defaultValue: defaultValue,
        commissionPercent: commissionPercent,
        currency: (currency ?? _defaultCurrency).isoCode,
        color: color == null ? '' : KaziHexColor.encode(color),
      ),
    );

    final newItems = List<CatalogItem>.from(current.catalogItems)..add(created);
    final typeCurrency = created.currency.isEmpty
        ? _defaultCurrency.isoCode
        : created.currency;
    state = AsyncData(
      current.copyWith(
        catalogItems: newItems,
        service: current.service.copyWith(
          catalogItem: created,
          catalogItemId: created.id,
          value: created.defaultValue,
          // Concrete, never null: a service the user never opens the commission
          // field on must be worth all of its value, not none of it.
          commissionPercent: created.effectiveCommissionPercent ?? 100,
          currency: typeCurrency,
        ),
      ),
    );

    ref.read(catalogControllerProvider.notifier).appendCatalogItem(created);

    unawaited(
      _analytics.log(
        AnalyticsEvent.catalogItemCreated,
        parameters: const {'source': 'quick_add'},
      ),
    );

    // Counts toward the ad frequency but never surfaces the ad inline: the user
    // is still filling out the service form.
    await ref
        .read(creationAdCoordinatorProvider.future)
        .then((coordinator) => coordinator.onCreationAction(canShowNow: false));
  }

  /// The active client already carrying [name], with what makes it
  /// recognizable, or null when there is no namesake.
  ///
  /// Asked by the quick-add sheet before it writes, so a namesake is a choice
  /// the user makes rather than a second row they find later. It never blocks:
  /// see [ClientNamesakeRule].
  Future<ClientNamesake?> findClientNamesake({
    required String name,
    required String identifier,
  }) async {
    final current = state.asData?.value;
    if (current == null) return null;

    final client = await ClientNamesakeRule.find(
      _clientsRepository,
      ownerId: current.userId,
      name: name,
      identifier: identifier,
    );
    if (client == null) return null;

    return (client: client, serviceCount: await _serviceCountOf(client));
  }

  /// How many services the namesake has, or null when nothing can say.
  ///
  /// The denormalized counter first, because it is already on the document the
  /// search returned. Only when it is absent — a client whose services predate
  /// the counters — does this spend a read, and only then: the count is what
  /// makes the name recognizable, and the warning is worth one aggregate.
  ///
  /// A failure is null and not zero. "Com 0 serviços" next to a name the user
  /// recognizes reads as a wrong fact rather than as a missing one.
  Future<int?> _serviceCountOf(ClientEntry client) async {
    if (!client.counters.isMissing) return client.counters.count;

    final current = state.asData?.value;
    if (current == null) return null;

    try {
      return await _servicesRepository.countByClient(current.userId, client.id);
    } catch (_) {
      return null;
    }
  }

  /// Selects a client that already exists, instead of creating the one the
  /// sheet was about to.
  ///
  /// It is appended to the picker when the form has not loaded it: the form
  /// holds the first hundred clients, and a namesake found by query is often
  /// not among them.
  void useExistingClient(ClientEntry entry) {
    final current = state.asData?.value;
    if (current == null) return;

    final isLoaded = current.clients.any((client) => client.id == entry.id);
    final clients = isLoaded
        ? current.clients
        : (List<ClientEntry>.from(current.clients)..add(entry));

    state = AsyncData(
      current.copyWith(
        clients: clients,
        service: current.service.copyWith(
          clientId: entry.id,
          clientName: entry.info.user.name,
        ),
      ),
    );
  }

  Future<void> quickAddClient({
    required String identifier,
    required String name,
    required String phone,
    String observation = '',
  }) async {
    final current = state.asData?.value;
    if (current == null) return;

    final trimmedIdentifier = identifier.trim();
    final trimmedName = name.trim();
    final trimmedPhone = phone.trim();
    if (trimmedName.isEmpty) {
      throw ClientError(
        KaziLocalizations.current.requiredProperty(
          KaziLocalizations.current.name,
        ),
      );
    }
    if (trimmedPhone.isEmpty) {
      throw ClientError(
        KaziLocalizations.current.requiredProperty(
          KaziLocalizations.current.phone,
        ),
      );
    }

    final gate = await _freemiumGuard.checkAddClient(current.userId);
    if (gate.isBlocked) {
      _promptPaywall(gate.blockedBy!);
      return;
    }

    await ClientDocumentRule.ensureFree(
      _clientsRepository,
      ownerId: current.userId,
      identifier: trimmedIdentifier,
    );

    final user = User(
      id: 0,
      name: trimmedName,
      email: '',
      document: trimmedIdentifier,
      birthDate: DateTime(2000),
      userType: UserType.client,
      authToken: '',
      refreshToken: '',
      authExpires: DateTime(2100),
      phones: [trimmedPhone],
    );

    final trimmedObservation = observation.trim();
    final id = await _clientsRepository.add(
      current.userId,
      user,
      observation: trimmedObservation,
    );
    final ClientEntry entry = (
      id: id,
      info: ClientInfo(
        user: user,
        lastServiceName: '',
        lastServiceDate: DateTime(2000),
        mostUsedServices: const {},
      ),
      archivedAt: null,
      counters: const RecordCounters(),
      observation: trimmedObservation,
    );

    final newClients = List<ClientEntry>.from(current.clients)..add(entry);
    state = AsyncData(
      current.copyWith(
        clients: newClients,
        service: current.service.copyWith(
          clientId: id,
          clientName: trimmedName,
        ),
      ),
    );

    ref.read(clientsControllerProvider.notifier).appendClient(entry);

    unawaited(
      _analytics.log(
        AnalyticsEvent.clientCreated,
        parameters: const {'source': 'quick_add'},
      ),
    );

    // Counts toward the ad frequency but never surfaces the ad inline: the user
    // is still filling out the service form.
    await ref
        .read(creationAdCoordinatorProvider.future)
        .then((coordinator) => coordinator.onCreationAction(canShowNow: false));
  }

  Future<void> _denormalizeLastService(ServiceFormState state) async {
    final clientId = state.service.clientId;
    if (clientId == null || clientId.isEmpty) return;

    final catalogItemName = state.catalogItems
        .where((item) => item.id == state.service.catalogItemId)
        .map((item) => item.name)
        .firstOrNull;

    await _clientsRepository.updateLastService(
      clientId,
      catalogItemName ?? '',
      state.service.date,
    );
  }

  Future<void> addService() async {
    final current = state.asData?.value;
    if (current == null) return;

    try {
      _checkServiceValidity(current);

      final gate = await _freemiumGuard.checkAddServices(
        current.userId,
        current.quantity,
      );
      if (gate.isBlocked) {
        _promptPaywall(gate.blockedBy!);
        return;
      }

      state = AsyncData(current.copyWith(status: BaseStateStatus.loading));
      final latest = state.asData?.value;
      if (latest == null) return;
      final serviceToSave = await _withRateAnchor(latest.service);
      await _servicesRepository.add(serviceToSave, latest.quantity);
      await _denormalizeLastService(latest);
      _reportCreation(latest, serviceToSave);
      final reviewManager = await ref.read(inAppReviewManagerProvider.future);
      await reviewManager.onServiceCreated();
      await ref
          .read(creationAdCoordinatorProvider.future)
          .then((coordinator) => coordinator.onCreationAction());
      _cleanState();
    } on AppError catch (exception) {
      _hadValidationError = true;
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  /// Shape only — how many, in what currency, with or without a client — never
  /// the amount and never the client.
  void _reportCreation(ServiceFormState state, Service saved) {
    _didCreate = true;

    final openedAt = _openedAt;
    final now = ref.read(timeServiceProvider).now;

    unawaited(
      _analytics.log(
        AnalyticsEvent.serviceCreated,
        parameters: {
          'quantity': state.quantity,
          'currency': saved.currency,
          'has_client': (saved.clientId ?? '').isNotEmpty,
          'commission_configured': saved.effectiveCommissionPercent != 100,
          if (openedAt != null)
            'seconds_to_create': now.difference(openedAt).inSeconds,
        },
      ),
    );

    ref.read(frictionDetectorProvider).onFormCompleted(_formName);
    unawaited(_maybeReportFirstService(state.userId, state.quantity));
  }

  /// Fires the activation milestone the first time an account records anything.
  ///
  /// The count query runs once per account — the uid is stamped afterwards, so
  /// the answer is not re-bought on every service somebody ever creates.
  Future<void> _maybeReportFirstService(String userId, int quantity) async {
    if (userId.isEmpty) return;

    try {
      final storage = await ref.read(localStorageProvider.future);
      final reportedFor = await storage.read<String>(
        StorageKeys.firstServiceReportedFor,
      );
      if (reportedFor == userId) return;

      final total = await _servicesRepository.count(userId);
      // `<=`, not `==`: a concurrent write from another device could push the
      // count past the quantity between the add and this read.
      if (total <= quantity) {
        await _analytics.log(AnalyticsEvent.firstServiceCreated);
      }

      await storage.write<String>(StorageKeys.firstServiceReportedFor, userId);
    } catch (exception) {
      // Missing the milestone costs a data point; failing here would cost the
      // user their work.
      Log.error(exception);
    }
  }

  Future<void> updateService() async {
    final current = state.asData?.value;
    if (current == null) return;

    try {
      _checkServiceValidity(current);
      state = AsyncData(current.copyWith(status: BaseStateStatus.loading));
      final latest = state.asData?.value;
      if (latest == null) return;
      final serviceToSave = await _withRateAnchor(latest.service);
      await _servicesRepository.update(serviceToSave);
      await _denormalizeLastService(latest);
      _cleanState();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  void _cleanState() {
    final current = state.asData?.value;
    if (current == null) return;
    final userId = _authService.user!.uid;
    state = AsyncData(
      current.copyWith(
        status: BaseStateStatus.success,
        quantity: 1,
        service: Service(userId: userId),
      ),
    );
  }

  void onChangeService(Service service) {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(service: service));
  }

  void onChangeServiceDescription(String value) {
    _touch('description');
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(service: current.service.copyWith(description: value)),
    );
  }

  void onChangeCatalogItem(DropdownItem dropdownItem) {
    _touch('type');
    final current = state.asData?.value;
    if (current == null) return;

    final defaultValue = _getDefaultValueToService(current, dropdownItem.value);
    final commission = _getDefaultCommissionToService(
      current,
      dropdownItem.value,
    );
    final catalogItem = current.catalogItems.firstWhere(
      (st) => st.id == dropdownItem.value,
    );
    // A service defaults to the currency of its catalog item (which itself falls back
    // to the user's profile currency when unset).
    final typeCurrency = catalogItem.currency.isEmpty
        ? _defaultCurrency.isoCode
        : catalogItem.currency;
    state = AsyncData(
      current.copyWith(
        service: current.service.copyWith(
          catalogItem: catalogItem,
          catalogItemId: dropdownItem.value,
          // Start from the item's saved value; fall back to the default (0)
          // when the item has none configured, rather than keeping a stale one.
          value: defaultValue ?? 0,
          // An item with no commission configured means the user keeps
          // everything — 100, never 0, which would zero the service out.
          commissionPercent: commission ?? 100,
          currency: typeCurrency,
        ),
      ),
    );
  }

  void onChangeServiceCurrency(SupportedCurrency currency) {
    _touch('currency');
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        service: current.service.copyWith(currency: currency.isoCode),
      ),
    );
  }

  double? _getDefaultValueToService(
    ServiceFormState current,
    String catalogItemId,
  ) {
    final catalogItem = current.catalogItems.firstWhere(
      (st) => st.id == catalogItemId,
    );
    return catalogItem.defaultValue;
  }

  double? _getDefaultCommissionToService(
    ServiceFormState current,
    String catalogItemId,
  ) {
    final catalogItem = current.catalogItems.firstWhere(
      (st) => st.id == catalogItemId,
    );
    return catalogItem.effectiveCommissionPercent;
  }

  void onChangeServiceValue(double value) {
    _touch('value');
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(service: current.service.copyWith(value: value)),
    );
  }

  void onChangeServicesQuantity(String value) {
    _touch('quantity');
    final current = state.asData?.value;
    if (current == null) return;
    final finalValue = int.tryParse(value);
    state = AsyncData(current.copyWith(quantity: finalValue));
  }

  void onChangeServiceCommission(double value) {
    _touch('commission');
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        service: current.service.copyWith(commissionPercent: value),
      ),
    );
  }

  void onChangeServiceDate(DateTime? value) {
    _touch('date');
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(service: current.service.copyWith(date: value)),
    );
  }

  void _checkServiceValidity(ServiceFormState current) {
    if (current.service.catalogItemId.isEmpty) {
      throw ClientError(
        KaziLocalizations.current.requiredProperty(
          KaziLocalizations.current.catalogItem,
        ),
      );
    }
  }
}
