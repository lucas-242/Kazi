import 'package:kazi/features/services/domain/models/receipt_filter.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/domain/models/service_view.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/clients/domain/repositories/clients_repository.dart';
import 'package:kazi/features/services/domain/services/service_organizer.dart';
import 'package:kazi/core/utils/base_notifier.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItemRepository, CatalogItem;

import 'service_landing_state.dart';
import 'service_receipt_controller.dart';

part 'service_landing_controller.g.dart';

@Riverpod(keepAlive: true)
class ServiceLandingController extends _$ServiceLandingController
    with BaseNotifier<ServiceLandingState> {
  ServicesRepository get _serviceProvidedRepository =>
      ref.read(servicesRepositoryProvider);

  CatalogItemRepository get _catalogItemRepository =>
      ref.read(catalogItemRepositoryProvider);

  AuthService get _authService => ref.read(authServiceProvider);

  ServiceOrganizer get _serviceOrganizer => ref.read(serviceOrganizerProvider);

  ClientsRepository get _clientsRepository => ref.read(clientsRepositoryProvider);

  /// How far back a search reaches. Before the app existed, so in practice
  /// "everything", without asking the query layer for an unbounded range.
  static final DateTime _searchFloor = DateTime.utc(2000);

  @override
  ServiceLandingState build() {
    // Recompute totals when the user switches their profile default currency.
    ref.listen(kaziDefaultCurrencyProvider, (_, next) {
      state = state.copyWith(defaultCurrency: next);
    });
    return ServiceLandingState(
      status: BaseStateStatus.loading,
      startDate: _serviceOrganizer.now,
      endDate: _serviceOrganizer.now,
      defaultCurrency: ref.read(kaziDefaultCurrencyProvider),
    );
  }

  /// Rate snapshots for every date present in [services]. Fail-open: an empty
  /// book still renders, with the totals flagged as incomplete.
  Future<RateBook> _loadRateBook(List<Service> services) async {
    try {
      final history = await ref.read(exchangeRateHistoryServiceProvider.future);
      return await history.bookFor(
        services.map((service) => service.effectiveRateDate),
      );
    } catch (_) {
      return const RateBook.empty();
    }
  }

  /// The window a refetch asks for. A hand-picked range has no preset to
  /// resolve, and resolving one anyway would snap the list back to today.
  (DateTime, DateTime) _currentRange() {
    if (state.fastSearch == FastSearch.custom) {
      return (state.startDate, state.endDate);
    }
    final range = _serviceOrganizer.getRangeDateByFastSearch(state.fastSearch);
    return (range['startDate']!, range['endDate']!);
  }

  Future<void> onInit() async {
    final generation = _readGeneration;
    _readsInFlight++;
    try {
      final (startDate, endDate) = _currentRange();
      final result = await _getServices(startDate, endDate);
      if (generation != _readGeneration) return;
      _handleGetServices(result, startDate, endDate);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    } finally {
      _readsInFlight--;
    }
  }

  Future<List<Service>> _getServices(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final result = await _serviceProvidedRepository.get(
      _authService.user!.uid,
      startDate,
      endDate,
    );
    return result;
  }

  Future<void> _handleGetServices(
    List<Service> fetchResult, [
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    try {
      final items = await _getCatalogItems();
      var services = _serviceOrganizer.addCatalogItemToServices(
        fetchResult,
        items,
      );
      // Rates first: ordering by value and summing both need every service
      // expressed in the same currency.
      final rateBook = await _loadRateBook(services);

      services = _serviceOrganizer.orderServices(
        services,
        state.selectedOrderBy,
        currency: state.defaultCurrency,
        rateBook: rateBook,
      );

      final newStatus = fetchResult.isEmpty
          ? BaseStateStatus.noData
          : BaseStateStatus.success;
      state = state.copyWith(
        status: newStatus,
        services: services,
        startDate: startDate,
        endDate: endDate,
        rateBook: rateBook,
      );
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<List<CatalogItem>> _getCatalogItems() async {
    final result = await _catalogItemRepository.get(_authService.user!.uid);
    return result;
  }

  /// Bumped whenever a read in flight is abandoned. A read compares the value
  /// it started with against this one before writing, and throws its answer
  /// away when they differ — the screen it was for is no longer on.
  int _readGeneration = 0;

  int _readsInFlight = 0;

  /// Whether leaving the tab dropped a read, so coming back has to ask again.
  bool _hasAbandonedRead = false;

  /// Abandons whatever this tab was fetching, because the tab was left.
  /// [resumeAbandonedRead] asks again on the way back. See the loading-scope
  /// rules in `themes/README.md`.
  void cancelPendingRead() {
    _readGeneration++;
    if (_readsInFlight > 0) _hasAbandonedRead = true;
  }

  /// Refetches when the last visit ended with a read dropped. Without it the
  /// tab keeps what it held before that read — after an edit, the old service.
  Future<void> resumeAbandonedRead() async {
    if (!_hasAbandonedRead) return;
    _hasAbandonedRead = false;
    await onRefresh();
  }

  Future<void> onRefresh() async {
    final generation = _readGeneration;
    _readsInFlight++;
    try {
      state = state.copyWith(status: BaseStateStatus.loading);
      final (startDate, endDate) = _currentRange();
      final result = await _getServices(startDate, endDate);
      if (generation != _readGeneration) return;
      _handleGetServices(result, startDate, endDate);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    } finally {
      _readsInFlight--;
    }
  }

  Future<void> deleteService(Service service) async {
    try {
      state = state.copyWith(status: BaseStateStatus.loading);
      await _serviceProvidedRepository.delete(service.id);
      final newList = await _getServices(state.startDate, state.endDate);
      _handleGetServices(newList);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> onApplyFilters([
    FastSearch? fastSearch,
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    if (fastSearch != null && fastSearch != FastSearch.custom) {
      await _onChageSelectedFastSearch(fastSearch);
    } else if (startDate != null && endDate != null) {
      await _onChangeDate(startDate, endDate);
    }
  }

  Future<void> _onChageSelectedFastSearch(FastSearch fastSearch) async {
    try {
      if (fastSearch == state.fastSearch) return;

      final range = _serviceOrganizer.getRangeDateByFastSearch(fastSearch);

      state = state.copyWith(
        status: BaseStateStatus.loading,
        fastSearch: fastSearch,
        startDate: range['startDate']!,
        endDate: range['endDate']!,
      );
      final fetchResult = await _getServices(
        range['startDate']!,
        range['endDate']!,
      );
      _handleGetServices(fetchResult);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> _onChangeDate(DateTime startDate, DateTime endDate) async {
    try {
      state = state.copyWith(
        status: BaseStateStatus.loading,
        startDate: startDate,
        endDate: endDate,
        fastSearch: FastSearch.custom,
      );
      final fetchResult = await _getServices(startDate, endDate);
      _handleGetServices(fetchResult, startDate, endDate);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  Future<void> onCleanFilters() async {
    state = ServiceLandingState(
      status: BaseStateStatus.loading,
      startDate: _serviceOrganizer.now,
      endDate: _serviceOrganizer.now,
      defaultCurrency: state.defaultCurrency,
      rateBook: state.rateBook,
      // Carried over: clearing filters is about what is listed, not about how
      // it is represented. Snapping back to the list would be a second,
      // unasked-for change.
      view: state.view,
    );
    onInit();
  }

  /// Flips between the list and the summary. Same services, same filters —
  /// nothing is refetched.
  void onChangeView(ServiceView view) {
    if (view == state.view) return;
    state = state.copyWith(view: view);
  }

  /// Both chip filters run over the list already in memory, so neither
  /// re-queries Firestore; the period is the only thing the query knows about.
  void onChangeReceiptFilter(ReceiptFilter receiptFilter) {
    if (receiptFilter == state.receiptFilter) return;
    state = state.copyWith(receiptFilter: receiptFilter);
  }

  /// Narrows to one client, or to every client when [clientId] is null.
  void onSelectClient(String? clientId) {
    if (clientId == state.clientId) return;
    state = state.copyWith(clientId: clientId);
  }

  /// Adds or removes one catalog item from the type filter. An empty set means
  /// every type, so unticking the last one is the same as not filtering.
  void onToggleCatalogItem(String catalogItemId) {
    final selected = {...state.catalogItemIds};
    if (!selected.remove(catalogItemId)) selected.add(catalogItemId);
    state = state.copyWith(catalogItemIds: selected);
  }

  /// Applies the filter sheet's draft in one go. They all run over the list
  /// already in memory, so this never touches Firestore — the period, applied
  /// separately, is the only filter the query knows about.
  void applySecondaryFilters({
    required ReceiptFilter receiptFilter,
    required Set<String> catalogItemIds,
    required String? clientId,
  }) {
    state = state.copyWith(
      receiptFilter: receiptFilter,
      catalogItemIds: catalogItemIds,
      clientId: clientId,
    );
  }

  /// Puts the in-memory filters back where they started, leaving the period
  /// alone: clearing from a no-results screen must bring rows back without a
  /// refetch, and the period is the only filter the query knows about.
  void onClearFilters() {
    if (!state.hasSecondaryFilters) return;
    state = state.copyWith(
      receiptFilter: ReceiptFilter.all,
      clientId: null,
      catalogItemIds: const {},
    );
  }

  /// Opens the tab on a given cut. The single entry point behind every
  /// "ver mais" in the app: a shortcut applies filters here and lands on this
  /// screen, where the chips show what was applied and the person can undo it.
  /// No shortcut opens a screen of its own.
  Future<void> openServices({
    ServiceView? view,
    FastSearch? period,
    String? clientId,
    String? catalogItemId,
  }) async {
    state = state.copyWith(
      view: view,
      clientId: clientId,
      catalogItemIds: catalogItemId == null ? const {} : {catalogItemId},
      receiptFilter: ReceiptFilter.all,
      isSearching: false,
      searchTerm: '',
    );

    if (period != null && period != state.fastSearch) {
      await _onChageSelectedFastSearch(period);
    }
  }

  /// Opens the list on one catalog item's services, over the days they span.
  ///
  /// The item reports a lifetime count, so leaving the period on the current
  /// month would list fewer rows than the count that was tapped. Costs the same
  /// unbounded read search does.
  Future<void> openCatalogItemHistory(String catalogItemId) async {
    state = state.copyWith(
      status: BaseStateStatus.loading,
      view: ServiceView.list,
      clientId: null,
      catalogItemIds: {catalogItemId},
      receiptFilter: ReceiptFilter.all,
      isSearching: false,
      searchTerm: '',
    );

    try {
      final everything = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        _searchFloor,
      );
      final dates = [
        for (final service in everything)
          if (service.catalogItemId == catalogItemId) service.date,
      ];
      final now = _serviceOrganizer.now;
      final startDate = dates
          .fold(now, (earliest, date) => date.isBefore(earliest) ? date : earliest)
          .firstHourOfDay;
      final endDate = dates
          .fold(now, (latest, date) => date.isAfter(latest) ? date : latest)
          .lastHourOfDay;

      state = state.copyWith(
        fastSearch: FastSearch.custom,
        startDate: startDate,
        endDate: endDate,
      );
      await _handleGetServices(
        [
          for (final service in everything)
            if (!service.date.isBefore(startDate) &&
                !service.date.isAfter(endDate))
              service,
        ],
        startDate,
        endDate,
      );
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  /// Opens the search mode and loads what it searches over.
  ///
  /// The fetch is deliberately unbounded in time and happens once, on opening:
  /// search ignores the period, and re-querying on every keystroke would spend
  /// a read per character to answer a question the device can already answer.
  Future<void> onOpenSearch() async {
    if (state.isSearching) return;
    state = state.copyWith(isSearching: true, searchTerm: '');

    if (state.searchServices.isNotEmpty) return;

    try {
      final fetched = await _serviceProvidedRepository.get(
        _authService.user!.uid,
        _searchFloor,
      );
      final items = await _getCatalogItems();
      state = state.copyWith(
        searchServices: _serviceOrganizer.addCatalogItemToServices(
          fetched,
          items,
        ),
      );
    } catch (_) {
      // Swallowed: search falls back to what the period already loaded rather
      // than taking the screen down. The empty result says so on its own.
      state = state.copyWith(searchServices: state.services);
    }
  }

  void onCloseSearch() {
    if (!state.isSearching) return;
    state = state.copyWith(isSearching: false, searchTerm: '');
  }

  Future<void> onSearchTermChanged(String term) async {
    state = state.copyWith(searchTerm: term);

    final trimmed = term.trim();
    if (trimmed.isEmpty) {
      state = state.copyWith(searchClients: const []);
      return;
    }

    try {
      final clients = await _clientsRepository.searchByName(
        _authService.user!.uid,
        trimmed,
      );
      // The term may have moved on while the query was in flight; a late
      // answer must not overwrite the current one.
      if (state.searchTerm != term) return;
      state = state.copyWith(searchClients: clients);
    } catch (_) {
      if (state.searchTerm == term) {
        state = state.copyWith(searchClients: const []);
      }
    }
  }

  void onChangeOrderBy(OrderBy orderBy) {
    final services = _serviceOrganizer.orderServices(
      state.services,
      orderBy,
      currency: state.defaultCurrency,
      rateBook: state.rateBook,
    );
    state = state.copyWith(services: services, selectedOrderBy: orderBy);
  }

  /// Applies payment stamps already written by `ServiceReceiptController`,
  /// patching the in-memory list instead of refetching. Ids not in this list
  /// are ignored, so the same call can be broadcast to every list.
  void applyReceipt(Map<String, DateTime?> stamps) {
    if (stamps.isEmpty) return;

    state = state.copyWith(
      services: [
        for (final service in state.services)
          if (!stamps.containsKey(service.id))
            service
          else if (stamps[service.id] case final DateTime at)
            service.markedReceivedAt(at)
          else
            service.notReceived(),
      ],
    );
  }

  /// Stamps every service currently listed that is still owed.
  ///
  /// Deliberately scoped to `state.visibleServices` — what the user can see —
  /// rather than to the billing cycle or to everything fetched: this tab has a
  /// window of its own, and the receipt and client chips narrow it further.
  /// Stamping beyond the visible list would pay off services the user never
  /// looked at, and the button's own count is drawn from the same list.
  ///
  /// Skips the already-received, or the batch would rewrite their stamps and
  /// move people's payment dates.
  Future<List<String>> markListedAsReceived() async {
    final pending = state.visibleServices.where(
      (service) => !service.isReceived,
    );
    return ref
        .read(serviceReceiptControllerProvider.notifier)
        .setReceived(pending.toList(), received: true);
  }

  Future<void> onChangeServices() async {
    try {
      state = state.copyWith(status: BaseStateStatus.loading);
      final result = await _getServices(state.startDate, state.endDate);
      _handleGetServices(result);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}
