// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/features/services/domain/models/receipt_filter.dart';
import 'package:kazi/features/services/domain/models/service_view.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/services/data/services/local_service_organizer.dart';
import 'package:kazi/features/services/domain/services/service_organizer.dart';
import 'package:kazi/core/services/data/local_time_service.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_state.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../../utils/test_helper.dart';
import 'service_landing_controller_test.mocks.dart';

@GenerateMocks([CatalogItemRepository, ServicesRepository, AuthService])
void main() {
  late MockCatalogItemRepository catalogItemRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late LocalTimeService timeService;
  late ServiceOrganizer serviceOrganizer;
  late ProviderContainer container;

  TestHelper.loadAppLocalizations();

  ServiceLandingController controller() =>
      container.read(serviceLandingControllerProvider.notifier);
  ServiceLandingState state() =>
      container.read(serviceLandingControllerProvider);

  // Flushes microtasks so fire-and-forget async work in the controller settles.
  Future<void> pump() => Future<void>.delayed(const Duration(milliseconds: 10));

  List<Override> overridesWith(ServiceOrganizer service) => [
    servicesRepositoryProvider.overrideWithValue(servicesRepository),
    catalogItemRepositoryProvider.overrideWithValue(catalogItemRepository),
    authServiceProvider.overrideWithValue(authService),
    serviceOrganizerProvider.overrideWithValue(service),
  ];

  // Rebuilds the container with a different ServiceOrganizer (used to control
  // the clock for FastSearch date-range assertions).
  void useServiceOrganizer(ServiceOrganizer service) {
    container.dispose();
    container = ProviderContainer(overrides: overridesWith(service));
  }

  setUp(() async {
    catalogItemRepository = MockCatalogItemRepository();
    servicesRepository = MockServicesRepository();
    timeService = LocalTimeService(serviceMock.date);
    serviceOrganizer = LocalServiceOrganizer(timeService);
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);
    when(
      catalogItemRepository.get(any),
    ).thenAnswer((_) async => catalogItemsWithIdsMock);
    when(
      servicesRepository.get(any, any, any),
    ).thenAnswer((_) async => servicesWithTypeIdMock);
    when(servicesRepository.delete(any)).thenAnswer((_) => Future.value());

    container = ProviderContainer(overrides: overridesWith(serviceOrganizer));
  });

  tearDown(() {
    container.dispose();
  });

  group('onInit', () {
    test('loads services newest first and status success', () async {
      await controller().onInit();
      await pump();

      expect(state().status, BaseStateStatus.success);
      expect(
        state().services,
        serviceOrganizer.orderServices(
          servicesWithTypesMock,
          OrderBy.dateDesc,
          currency: SupportedCurrency.usd,
          rateBook: const RateBook.empty(),
        ),
      );
    });

    test('status noData when there are no services', () async {
      when(servicesRepository.get(any, any, any)).thenAnswer((_) async => []);

      await controller().onInit();
      await pump();

      expect(state().status, BaseStateStatus.noData);
    });

    test(
      'status error with errorToGetServices when get throws AppError',
      () async {
        when(servicesRepository.get(any, any, any)).thenThrow(
          ExternalError(KaziLocalizations.current.errorToGetServices),
        );

        await controller().onInit();
        await pump();

        expect(state().status, BaseStateStatus.error);
        expect(
          state().callbackMessage,
          KaziLocalizations.current.errorToGetServices,
        );
      },
    );

    test(
      'status error with errorToGetCatalogItems when types get throws',
      () async {
        when(catalogItemRepository.get(any)).thenThrow(
          ExternalError(KaziLocalizations.current.errorToGetCatalogItems),
        );

        await controller().onInit();
        await pump();

        expect(state().status, BaseStateStatus.error);
        expect(
          state().callbackMessage,
          KaziLocalizations.current.errorToGetCatalogItems,
        );
      },
    );

    test('status error with unknowError on unexpected exception', () async {
      when(catalogItemRepository.get(any)).thenThrow(Exception());

      await controller().onInit();
      await pump();

      expect(state().status, BaseStateStatus.error);
      expect(
        state().callbackMessage,
        KaziLocalizations.current.errorUnknowError,
      );
    });
  });

  group('deleteService', () {
    test('deletes and refetches, ending in success', () async {
      final serviceToDelete = serviceMock.copyWith(id: '123456', catalogItemId: '1');

      await controller().deleteService(serviceToDelete);
      await pump();

      expect(state().status, BaseStateStatus.success);
      expect(
        state().services,
        serviceOrganizer.orderServices(
          servicesWithTypesMock,
          OrderBy.dateDesc,
          currency: SupportedCurrency.usd,
          rateBook: const RateBook.empty(),
        ),
      );
      verify(servicesRepository.delete(serviceToDelete.id)).called(1);
    });
  });

  group('onRefresh', () {
    test('ends in success after refetching', () async {
      await controller().onRefresh();
      await pump();

      expect(state().status, BaseStateStatus.success);
    });

    test('keeps a hand-picked range instead of snapping to today', () async {
      final start = DateTime(2022, 1, 1);
      final end = DateTime(2022, 1, 12);
      await controller().onApplyFilters(null, start, end);
      await pump();

      await controller().onRefresh();
      await pump();

      expect(state().fastSearch, FastSearch.custom);
      expect(state().startDate, start);
      expect(state().endDate, end);
    });
  });

  group('openCatalogItemHistory', () {
    test('lists the item over the days its services span', () async {
      final older = serviceMock.copyWith(
        id: 'older',
        catalogItemId: '1',
        date: DateTime(2021, 3, 10, 14),
      );
      final newer = serviceMock.copyWith(
        id: 'newer',
        catalogItemId: '1',
        date: DateTime(2021, 5, 2),
      );
      final otherItem = serviceMock.copyWith(
        id: 'other',
        catalogItemId: '2',
        date: DateTime(2021, 4, 1),
      );
      when(
        servicesRepository.get(any, any, any),
      ).thenAnswer((_) async => [older, otherItem, newer]);

      await controller().openCatalogItemHistory('1');
      await pump();

      expect(state().view, ServiceView.list);
      expect(state().fastSearch, FastSearch.custom);
      expect(state().catalogItemIds, {'1'});
      expect(state().startDate, DateTime(2021, 3, 10));
      expect(state().endDate.isBefore(DateTime(2021, 5, 2)), isFalse);
      expect(
        state().visibleServices.map((service) => service.id),
        unorderedEquals(['older', 'newer']),
      );
    });
  });

  group('onApplyFilters', () {
    test(
      'with custom dates updates range and flags active filters',
      () async {
        final newStartDateTime = DateTime(2022, 1, 1);
        final newEndDateTime = DateTime(2022, 1, 12);

        await controller().onApplyFilters(
          null,
          newStartDateTime,
          newEndDateTime,
        );
        await pump();

        expect(state().status, BaseStateStatus.success);
        expect(state().startDate, newStartDateTime);
        expect(state().endDate, newEndDateTime);
        expect(state().fastSearch, FastSearch.custom);
        expect(state().hasActiveFilters, isTrue);
      },
    );

    test(
      'with a FastSearch updates fastSearch and flags active filters',
      () async {
        useServiceOrganizer(
          LocalServiceOrganizer(LocalTimeService(DateTime(2022, 12, 12))),
        );

        await controller().onApplyFilters(FastSearch.fortnight);
        await pump();

        expect(state().status, BaseStateStatus.success);
        expect(state().fastSearch, FastSearch.fortnight);
        expect(state().hasActiveFilters, isTrue);
        expect(state().startDate, DateTime(2022, 12, 1));
        expect(state().endDate, DateTime(2022, 12, 15, 23, 59, 59));
      },
    );
  });

  group('onChangeServices', () {
    test('ends in success with the refetched services', () async {
      await controller().onChangeServices();
      await pump();

      expect(state().status, BaseStateStatus.success);
      expect(state().services, servicesWithTypesMock);
    });
  });

  group('onChangeOrderBy', () {
    test('reorders services and updates selectedOrderBy', () async {
      await controller().onInit();
      await pump();

      controller().onChangeOrderBy(OrderBy.dateDesc);

      expect(state().selectedOrderBy, OrderBy.dateDesc);
      expect(
        state().services,
        serviceOrganizer.orderServices(
          servicesWithTypesMock,
          OrderBy.dateDesc,
          currency: SupportedCurrency.usd,
          rateBook: const RateBook.empty(),
        ),
      );
    });
  });

  /// All three run over the list already in memory: the Firestore query only
  /// knows about the period, so none of them may cost a read.
  group('View and chip filters', () {
    test('onChangeView switches the view without refetching', () async {
      await controller().onInit();
      await pump();
      clearInteractions(servicesRepository);

      controller().onChangeView(ServiceView.summary);

      expect(state().view, ServiceView.summary);
      verifyNever(servicesRepository.get(any, any, any));
    });

    test('onChangeReceiptFilter narrows the list without refetching', () async {
      await controller().onInit();
      await pump();
      clearInteractions(servicesRepository);

      controller().onChangeReceiptFilter(ReceiptFilter.pending);

      expect(state().receiptFilter, ReceiptFilter.pending);
      expect(state().hasActiveFilters, isTrue);
      // Nothing in the mock is stamped as paid, so "pending" keeps them all.
      expect(state().visibleServices.length, state().services.length);
      verifyNever(servicesRepository.get(any, any, any));
    });

    test('onSelectClient narrows the list without refetching', () async {
      await controller().onInit();
      await pump();
      clearInteractions(servicesRepository);

      controller().onSelectClient('client-1');

      expect(state().clientId, 'client-1');
      expect(state().hasActiveFilters, isTrue);
      verifyNever(servicesRepository.get(any, any, any));
    });

    test('onSelectClient with null clears the client filter', () async {
      await controller().onInit();
      await pump();
      controller().onSelectClient('client-1');

      controller().onSelectClient(null);

      expect(state().clientId, isNull);
      expect(state().hasActiveFilters, isFalse);
    });

    test('putting a filter back to its default clears the badge', () async {
      await controller().onInit();
      await pump();
      controller().onChangeReceiptFilter(ReceiptFilter.pending);

      controller().onChangeReceiptFilter(ReceiptFilter.all);

      expect(state().hasActiveFilters, isFalse);
    });

    test('onCleanFilters resets the chips but keeps the view', () async {
      await controller().onInit();
      await pump();
      controller().onChangeView(ServiceView.summary);
      controller().onChangeReceiptFilter(ReceiptFilter.received);
      controller().onSelectClient('client-1');

      await controller().onCleanFilters();
      await pump();

      expect(state().receiptFilter, ReceiptFilter.all);
      expect(state().clientId, isNull);
      expect(state().hasActiveFilters, isFalse);
      // Clearing filters is about what is listed, not how it is represented.
      expect(state().view, ServiceView.summary);
    });
  });

  group('State properties', () {
    ServiceLandingState buildState() => ServiceLandingState(
      services: servicesWithTypesMock,
      status: BaseStateStatus.success,
      selectedOrderBy: OrderBy.dateDesc,
      startDate: serviceOrganizer.now,
      endDate: serviceOrganizer.now,
    );

    test('totalValue should be 210', () {
      expect(buildState().totals.value, 210);
    });

    test('total commission should be 105', () {
      expect(buildState().totals.commission, 105);
    });

    test('total withheld should be 105', () {
      expect(buildState().totals.withheld, 105);
    });
  });
}
