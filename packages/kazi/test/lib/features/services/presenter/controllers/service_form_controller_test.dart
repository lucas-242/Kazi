import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/features/clients/domain/models/record_counters.dart';
import 'package:kazi/features/clients/domain/repositories/clients_repository.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_state.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:kazi_core/kazi_core.dart' hide CatalogItemRepository, Service;
import 'package:kazi_core/shared/services/in_app_review/kazi_in_app_review_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/client_mocks.dart';
import '../../../../../mocks/mocks.dart';
import '../../../../../utils/fake_creation_ad_coordinator.dart';
import '../../../../../utils/fakes/fake_analytics_service.dart';
import '../../../../../utils/fakes/fake_local_storage.dart';
import '../../../../../utils/fake_subscription_service.dart';
import '../../../../../utils/test_helper.dart';
import '../../../../../utils/test_matchers.dart';
import 'service_form_controller_test.mocks.dart';

@GenerateMocks([
  CatalogItemRepository,
  ServicesRepository,
  ClientsRepository,
  AuthService,
  KaziInAppReviewManager,
])
void main() {
  late MockCatalogItemRepository catalogItemRepository;
  late MockServicesRepository servicesRepository;
  late MockClientsRepository clientsRepository;
  late MockAuthService authService;
  late MockKaziInAppReviewManager inAppReviewManager;
  late FakeAnalyticsService analytics;
  late FakeCreationAdCoordinator creationAds;
  late ProviderContainer container;

  TestHelper.loadAppLocalizations();

  setUp(() async {
    catalogItemRepository = MockCatalogItemRepository();
    servicesRepository = MockServicesRepository();
    clientsRepository = MockClientsRepository();
    authService = MockAuthService();
    inAppReviewManager = MockKaziInAppReviewManager();
    analytics = FakeAnalyticsService();
    creationAds = FakeCreationAdCoordinator();

    when(authService.user).thenReturn(userMock);

    when(
      catalogItemRepository.get(any),
    ).thenAnswer((_) async => catalogItemsMock);

    when(
      clientsRepository.getClients(
        any,
        limit: anyNamed('limit'),
        startAfterName: anyNamed('startAfterName'),
      ),
    ).thenAnswer((_) async => []);

    when(
      clientsRepository.findByIdentifier(any, any),
    ).thenAnswer((_) async => null);

    when(inAppReviewManager.onServiceCreated()).thenAnswer((_) async {
      return;
    });
    when(inAppReviewManager.onAppStarted()).thenAnswer((_) async {
      return;
    });

    container = ProviderContainer(
      overrides: [
        servicesRepositoryProvider.overrideWithValue(servicesRepository),
        catalogItemRepositoryProvider.overrideWithValue(catalogItemRepository),
        clientsRepositoryProvider.overrideWithValue(clientsRepository),
        authServiceProvider.overrideWithValue(authService),
        subscriptionServiceProvider.overrideWithValue(
          FakeSubscriptionService(),
        ),
        freemiumGuardProvider.overrideWithValue(fakeFreemiumGuard()),
        inAppReviewManagerProvider.overrideWith(
          (ref) => Future.value(inAppReviewManager),
        ),
        creationAdCoordinatorProvider.overrideWith((ref) => creationAds),
        // The form reports opening, abandonment and creation. Without this the
        // real composite is built, and its Firebase sink needs an initialised
        // Firebase app that a unit test does not have.
        analyticsServiceProvider.overrideWithValue(analytics),
        localStorageProvider.overrideWith((ref) async => FakeLocalStorage()),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('Provider build', () {
    test('loads catalogItems and returns readyToUserInput', () async {
      final provider = serviceFormControllerProvider();
      final state = await container.read(provider.future);

      expect(state.userId, authService.user!.uid);
      expect(state.catalogItems, catalogItemsMock);
      expect(state.status, BaseStateStatus.readyToUserInput);
    });

    test(
      'prepares the interstitial when opened to create, not to edit',
      () async {
        await container.read(serviceFormControllerProvider().future);
        await container.read(
          serviceFormControllerProvider(service: serviceMock).future,
        );
        await Future<void>.delayed(Duration.zero);

        expect(creationAds.prepareCount, 1);
      },
    );

    test('uses passed service when building', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      final state = await container.read(provider.future);

      expect(state.service, serviceMock);
      expect(state.status, BaseStateStatus.readyToUserInput);
    });

    test(
      'stays readyToUserInput when catalogItems is empty (inline quick-add)',
      () async {
        when(catalogItemRepository.get(any)).thenAnswer((_) async => []);

        final provider = serviceFormControllerProvider();
        final state = await container.read(provider.future);

        expect(state.status, BaseStateStatus.readyToUserInput);
        expect(state.catalogItems, isEmpty);
      },
    );

    test(
      'returns error state with callbackMessage when get catalogItems throws AppError',
      () async {
        when(catalogItemRepository.get(any)).thenThrow(
          ExternalError(KaziLocalizations.current.errorToGetCatalogItems),
        );

        final provider = serviceFormControllerProvider();
        final state = await container.read(provider.future);

        expect(state.status, BaseStateStatus.error);
        expect(
          state.callbackMessage,
          KaziLocalizations.current.errorToGetCatalogItems,
        );
      },
    );

    test(
      'returns unknowError when get catalogItems throws unexpected exception',
      () async {
        when(catalogItemRepository.get(any)).thenThrow(Exception());

        final provider = serviceFormControllerProvider();
        final state = await container.read(provider.future);

        expect(state.status, BaseStateStatus.error);
        expect(
          state.callbackMessage,
          KaziLocalizations.current.errorUnknowError,
        );
      },
    );
  });

  group('Add Service', () {
    const quantityServices = 3;

    test('transitions to loading and then success, clearing state', () async {
      when(
        servicesRepository.add(any, any),
      ).thenAnswer((_) async => servicesMock);

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final emitted = <ServiceFormState>[];
      final sub = container.listen<AsyncValue<ServiceFormState>>(provider, (
        _,
        next,
      ) {
        final value = next.asData?.value;
        if (value != null) emitted.add(value);
      });

      final controller = container.read(provider.notifier);
      controller.onChangeService(serviceMock);
      controller.onChangeServicesQuantity(quantityServices.toString());
      await controller.addService();

      sub.close();

      expect(emitted.any((s) => s.status == BaseStateStatus.loading), isTrue);
      expect(emitted.last.status, BaseStateStatus.success);
      expect(emitted.last.quantity, 1);
      expect(emitted.last.service.userId, authService.user!.uid);
      verify(servicesRepository.add(any, quantityServices)).called(1);
      expect(creationAds.actions, [
        true,
      ], reason: 'a save counts once, whatever its quantity');
    });
  });

  group('Update Service', () {
    test('transitions to loading and then success, clearing state', () async {
      when(servicesRepository.update(any)).thenAnswer((_) async {});

      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      final emitted = <ServiceFormState>[];
      final sub = container.listen<AsyncValue<ServiceFormState>>(provider, (
        _,
        next,
      ) {
        final value = next.asData?.value;
        if (value != null) emitted.add(value);
      });

      final controller = container.read(provider.notifier);
      await controller.updateService();

      sub.close();

      expect(emitted.any((s) => s.status == BaseStateStatus.loading), isTrue);
      expect(emitted.last.status, BaseStateStatus.success);
      verify(servicesRepository.update(any)).called(1);
    });
  });

  group('Change properties', () {
    const newCommissionPercent = 1.0;
    const newValue = 99.0;
    const newDescription = 'new description';
    final newDateTime = DateTime.now();

    test('updates date', () async {
      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      controller.onChangeServiceDate(newDateTime);

      final state = container.read(provider).asData?.value;
      expect(state, isNotNull);
      expect(state!.service.date, newDateTime);
    });

    test('updates description', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      controller.onChangeServiceDescription(newDescription);

      final state = container.read(provider).asData?.value;
      expect(state, isNotNull);
      expect(state!.service.description, newDescription);
    });

    test('updates value', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      controller.onChangeServiceValue(newValue);

      final state = container.read(provider).asData?.value;
      expect(state, isNotNull);
      expect(state!.service.value, newValue);
    });

    test('updates commission percent', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      controller.onChangeServiceCommission(newCommissionPercent);

      final state = container.read(provider).asData?.value;
      expect(state, isNotNull);
      expect(state!.service.commissionPercent, newCommissionPercent);
    });

    test('links a client', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      container
          .read(provider.notifier)
          .onChangeClient(DropdownItem(value: 'client-1', label: 'Marina'));

      final state = container.read(provider).asData?.value;
      expect(state!.service.clientId, 'client-1');
      expect(state.service.clientName, 'Marina');
    });

    /// The picker's clear button emits null. `copyWith` cannot write one, so
    /// this used to be a no-op: the field looked empty and saved the old client
    /// straight back.
    test('unlinks a client when the picker is cleared', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      controller.onChangeClient(
        DropdownItem(value: 'client-1', label: 'Marina'),
      );
      controller.onChangeClient(null);

      final state = container.read(provider).asData?.value;
      expect(state!.service.clientId, isNull);
      expect(state.service.clientName, isNull);
    });

    test('keeps the rest of the service when unlinking a client', () async {
      final provider = serviceFormControllerProvider(service: serviceMock);
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      controller.onChangeServiceValue(99);
      controller.onChangeClient(null);

      final state = container.read(provider).asData?.value;
      expect(state!.service.value, 99);
      expect(state.service.catalogItemId, serviceMock.catalogItemId);
      expect(state.service.date, serviceMock.date);
    });
  });

  group('Quick add service type', () {
    test('appends the created type in place and auto-selects it', () async {
      final created = catalogItemMock.copyWith(
        id: 'new-type-id',
        name: 'Barber',
        defaultValue: 42,
        commissionPercent: 5,
      );
      when(catalogItemRepository.add(any)).thenAnswer((_) async => created);

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      await controller.quickAddCatalogItem(
        name: 'Barber',
        defaultValue: 42,
        commissionPercent: 5,
      );

      final state = container.read(provider).asData?.value;
      expect(state, isNotNull);
      expect(state!.catalogItems.contains(created), isTrue);
      expect(state.service.catalogItemId, created.id);
      expect(state.service.value, created.defaultValue);
      expect(state.service.commissionPercent, created.commissionPercent);
      // The list was appended in place: get() was only called once, at build.
      verify(catalogItemRepository.get(any)).called(1);
    });

    test('saves the type in the currency picked in the sheet', () async {
      when(catalogItemRepository.add(any)).thenAnswer(
        (_) async => catalogItemMock.copyWith(
          id: 'new-type-id',
          name: 'Barber',
          currency: 'EUR',
        ),
      );

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      await container
          .read(provider.notifier)
          .quickAddCatalogItem(name: 'Barber', currency: SupportedCurrency.eur);

      final saved = verify(
        catalogItemRepository.add(captureAny),
      ).captured.single;
      expect(saved.currency, 'EUR');
      expect(container.read(provider).asData?.value.service.currency, 'EUR');
    });

    test('throws when the name duplicates an existing type', () async {
      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final controller = container.read(provider.notifier);

      expect(
        () => controller.quickAddCatalogItem(name: catalogItemsMock.first.name),
        throwsA(isA<AppError>()),
      );
      verifyNever(catalogItemRepository.add(any));
    });
  });

  group('Quick add client', () {
    test('appends the created client in place and auto-selects it', () async {
      when(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      ).thenAnswer((_) async => 'new-client-id');

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final controller = container.read(provider.notifier);
      await controller.quickAddClient(
        identifier: '12345678900',
        name: 'Ada Lovelace',
        phone: '+551199999999',
      );

      final state = container.read(provider).asData?.value;
      expect(state, isNotNull);
      expect(state!.clients.length, 1);
      expect(state.clients.first.id, 'new-client-id');
      expect(state.clients.first.info.user.name, 'Ada Lovelace');
      expect(state.service.clientId, 'new-client-id');
      expect(state.service.clientName, 'Ada Lovelace');
    });

    test('throws when a required field is empty', () async {
      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final controller = container.read(provider.notifier);

      expect(
        () => controller.quickAddClient(
          identifier: '12345678900',
          name: '',
          phone: '123',
        ),
        throwsA(isA<AppError>()),
      );
      expect(
        () => controller.quickAddClient(
          identifier: '12345678900',
          name: 'Ada',
          phone: '',
        ),
        throwsA(isA<AppError>()),
      );
      verifyNever(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      );
    });

    test('finds a namesake, and ignores one with another document', () async {
      when(clientsRepository.searchByName(any, any)).thenAnswer(
        (_) async => [clientEntryMock(id: 'existing', name: 'Ana Maria')],
      );

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);
      final controller = container.read(provider.notifier);

      final found = await controller.findClientNamesake(
        name: '  ana maria ',
        identifier: '',
      );
      // Matched normalized: the stored name is the one the query is a prefix
      // of, so casing and spacing must not decide it.
      expect(found?.client.id, 'existing');

      when(clientsRepository.searchByName(any, any)).thenAnswer(
        (_) async => [
          clientEntryMock(
            id: 'existing',
            name: 'Ana Maria',
            identifier: '11111111111',
          ),
        ],
      );

      // Two filled documents that differ settle it as a coincidence.
      expect(
        await controller.findClientNamesake(
          name: 'Ana Maria',
          identifier: '22222222222',
        ),
        isNull,
      );
    });

    test(
      'counts the namesake services only when the counters cannot',
      () async {
        when(clientsRepository.searchByName(any, any)).thenAnswer(
          (_) async => [
            clientEntryMock(
              id: 'existing',
              name: 'Ana Maria',
              counters: const RecordCounters(count: 7),
            ),
          ],
        );

        final provider = serviceFormControllerProvider();
        await container.read(provider.future);
        final controller = container.read(provider.notifier);

        var found = await controller.findClientNamesake(
          name: 'Ana Maria',
          identifier: '',
        );
        expect(found?.serviceCount, 7);
        // The counter answered, so the aggregate is never spent.
        verifyNever(servicesRepository.countByClient(any, any));

        when(clientsRepository.searchByName(any, any)).thenAnswer(
          (_) async => [clientEntryMock(id: 'existing', name: 'Ana Maria')],
        );
        when(
          servicesRepository.countByClient(any, any),
        ).thenAnswer((_) async => 12);

        found = await controller.findClientNamesake(
          name: 'Ana Maria',
          identifier: '',
        );
        // Counters absent — a client whose services predate them — so the count
        // is worth one read rather than leaving the name unqualified.
        expect(found?.serviceCount, 12);
        verify(servicesRepository.countByClient(any, 'existing')).called(1);
      },
    );

    test('a count that cannot be taken is null, never zero', () async {
      when(clientsRepository.searchByName(any, any)).thenAnswer(
        (_) async => [clientEntryMock(id: 'existing', name: 'Ana Maria')],
      );
      when(
        servicesRepository.countByClient(any, any),
      ).thenThrow(ExternalError('boom'));

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final found = await container
          .read(provider.notifier)
          .findClientNamesake(name: 'Ana Maria', identifier: '');
      expect(found, isNotNull);
      expect(found?.serviceCount, isNull);
    });

    test('a failed namesake lookup never blocks the creation', () async {
      when(
        clientsRepository.searchByName(any, any),
      ).thenThrow(ExternalError('boom'));

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      expect(
        await container
            .read(provider.notifier)
            .findClientNamesake(name: 'Ana Maria', identifier: ''),
        isNull,
      );
    });

    test('using the existing client selects it without writing', () async {
      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      final existing = clientEntryMock(id: 'existing', name: 'Ana Maria');
      container.read(provider.notifier).useExistingClient(existing);

      final state = container.read(provider).asData?.value;
      expect(state!.service.clientId, 'existing');
      expect(state.service.clientName, 'Ana Maria');
      // Appended, because the form loads only the first page of clients and a
      // namesake found by query is often not in it.
      expect(state.clients.single.id, 'existing');
      verifyNever(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      );
    });

    test('refuses a document already on file', () async {
      // The quick-add goes through the same rule as the full form, or it would
      // be a way around it.
      when(clientsRepository.findByIdentifier(any, any)).thenAnswer(
        (_) async => clientEntryMock(id: 'existing', name: 'Ana Maria'),
      );

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      await expectLater(
        container
            .read(provider.notifier)
            .quickAddClient(
              identifier: '12345678900',
              name: 'Ada',
              phone: '123',
            ),
        ErrorWithMessage<ClientError>(
          KaziLocalizations.current.clientSameDocument('Ana Maria'),
        ),
      );
      verifyNever(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      );
    });

    test('refuses when the document check cannot run', () async {
      when(
        clientsRepository.findByIdentifier(any, any),
      ).thenThrow(Exception('boom'));

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      await expectLater(
        container
            .read(provider.notifier)
            .quickAddClient(
              identifier: '12345678900',
              name: 'Ada',
              phone: '123',
            ),
        ErrorWithMessage<ExternalError>(
          KaziLocalizations.current.errorToVerifyDocument,
        ),
      );
      verifyNever(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      );
    });

    test('creates without a document, which is optional', () async {
      when(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      ).thenAnswer((_) async => 'new-client-id');

      final provider = serviceFormControllerProvider();
      await container.read(provider.future);

      await container
          .read(provider.notifier)
          .quickAddClient(
            identifier: '',
            name: 'Ada Lovelace',
            phone: '+551199999999',
          );

      final state = container.read(provider).asData?.value;
      expect(state!.service.clientId, 'new-client-id');
      verify(
        clientsRepository.add(any, any, observation: anyNamed('observation')),
      ).called(1);
    });
  });
}
