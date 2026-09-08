import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_state.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide CatalogItem, CatalogItemRepository;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../utils/fakes/fake_analytics_service.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../../utils/fake_creation_ad_coordinator.dart';
import '../../../../../utils/fake_subscription_service.dart';
import '../../../../../utils/test_helper.dart';
import 'catalog_controller_test.mocks.dart';

@GenerateMocks([CatalogItemRepository, ServicesRepository, AuthService])
void main() {
  late MockCatalogItemRepository catalogItemRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late ProviderContainer container;

  TestHelper.loadAppLocalizations();

  CatalogController controller() =>
      container.read(catalogControllerProvider.notifier);
  CatalogState state() => container.read(catalogControllerProvider);

  setUp(() async {
    catalogItemRepository = MockCatalogItemRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);
    when(
      catalogItemRepository.get(any),
    ).thenAnswer((_) async => catalogItemsMock);
    when(
      catalogItemRepository.add(any),
    ).thenAnswer((_) async => catalogItemMock);

    container = ProviderContainer(
      overrides: [
        servicesRepositoryProvider.overrideWithValue(servicesRepository),
        // The creation path reports `client_created` / `limit_reached`.
        // Without this the real composite is built, and its Firebase sink
        // needs an initialised Firebase app a unit test does not have.
        analyticsServiceProvider.overrideWithValue(FakeAnalyticsService()),
        catalogItemRepositoryProvider.overrideWithValue(catalogItemRepository),
        authServiceProvider.overrideWithValue(authService),
        subscriptionServiceProvider.overrideWithValue(
          FakeSubscriptionService(),
        ),
        freemiumGuardProvider.overrideWithValue(fakeFreemiumGuard()),
        creationAdCoordinatorProvider.overrideWith(
          (ref) => FakeCreationAdCoordinator(),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('onInit', () {
    test('loads catalogItems and status readyToUserInput', () async {
      await controller().onInit();

      expect(state().status, BaseStateStatus.readyToUserInput);
      expect(state().catalogItems, catalogItemsMock);
    });

    test('status noData when there are no catalogItems', () async {
      when(catalogItemRepository.get(any)).thenAnswer((_) async => []);

      await controller().onInit();

      expect(state().status, BaseStateStatus.noData);
      expect(state().catalogItems, isEmpty);
    });
  });

  group('getCatalogItems', () {
    test('loads catalogItems and ends readyToUserInput', () async {
      await controller().getCatalogItems();

      expect(state().status, BaseStateStatus.readyToUserInput);
      expect(state().catalogItems, catalogItemsMock);
    });

    test('status error with errorToGetCatalogItems on AppError', () async {
      when(catalogItemRepository.get(any)).thenThrow(
        ExternalError(KaziLocalizations.current.errorToGetCatalogItems),
      );

      await controller().getCatalogItems();

      expect(state().status, BaseStateStatus.error);
      expect(
        state().callbackMessage,
        KaziLocalizations.current.errorToGetCatalogItems,
      );
    });

    test('status error with unknowError on unexpected exception', () async {
      when(catalogItemRepository.get(any)).thenThrow(Exception());

      await controller().getCatalogItems();

      expect(state().status, BaseStateStatus.error);
      expect(
        state().callbackMessage,
        KaziLocalizations.current.errorUnknowError,
      );
    });
  });

  group('addCatalogItem', () {
    test(
      'adds the catalogItem and ends in success with reset catalogItem',
      () async {
        controller().changeCatalogItem(catalogItemMock);
        await controller().addCatalogItem();

        expect(state().status, BaseStateStatus.success);
        expect(state().catalogItems, [catalogItemMock]);
        expect(state().catalogItem.id, isEmpty);
      },
    );
  });

  group('updateCatalogItem', () {
    test('updates and refetches catalogItems, ending in success', () async {
      controller().changeCatalogItem(catalogItemMock);
      await controller().updateCatalogItem();

      expect(state().status, BaseStateStatus.success);
      expect(state().catalogItems, catalogItemsMock);
    });
  });

  group('deleteCatalogItem', () {
    setUp(() {
      when(servicesRepository.count(any, any)).thenAnswer((_) async => 0);
    });

    test('deletes and refetches catalogItems, ending in success', () async {
      final catalogItemToDelete = catalogItemMock.copyWith(id: '123456');

      await controller().deleteCatalogItem(catalogItemToDelete);

      expect(state().status, BaseStateStatus.success);
      expect(state().catalogItems, catalogItemsMock);
    });
  });

  group('change properties', () {
    const newName = 'new name';
    const newDefaultValue = 9999.0;
    const newCommissionPercent = 1.0;

    test('eraseCatalogItem resets catalogItem', () {
      controller().changeCatalogItem(catalogItemMock);
      controller().eraseCatalogItem();

      expect(state().catalogItem.id, isEmpty);
      expect(state().catalogItem.name, isEmpty);
    });

    test('changeCatalogItemName updates name', () {
      controller().changeCatalogItem(catalogItemMock);
      controller().changeCatalogItemName(newName);

      expect(state().catalogItem, catalogItemMock.copyWith(name: newName));
    });

    test('changeCatalogItemDefaultValue updates defaultValue', () {
      controller().changeCatalogItem(catalogItemMock);
      controller().changeCatalogItemDefaultValue(newDefaultValue);

      expect(
        state().catalogItem,
        catalogItemMock.copyWith(defaultValue: newDefaultValue),
      );
    });

    test('changeCatalogItemCommissionPercent updates commissionPercent', () {
      controller().changeCatalogItem(catalogItemMock);
      controller().changeCatalogItemCommissionPercent(newCommissionPercent);

      expect(
        state().catalogItem,
        catalogItemMock.copyWith(commissionPercent: newCommissionPercent),
      );
    });
  });

  group('archiving', () {
    final active = catalogItemMock.copyWith(id: 'a', name: 'Manicure');
    final archived = catalogItemMock.copyWith(
      id: 'b',
      name: 'Pedicure',
      archivedAt: DateTime(2026, 8, 12),
    );

    setUp(() {
      when(
        catalogItemRepository.get(any),
      ).thenAnswer((_) async => [active, archived]);
      when(
        catalogItemRepository.archive(any),
      ).thenAnswer((_) async => DateTime(2026, 8, 24));
      when(catalogItemRepository.restore(any)).thenAnswer((_) async {});
    });

    test('keeps archived items in the list the services join against', () async {
      await controller().onInit();

      expect(state().catalogItems, hasLength(2));
      expect(state().activeCatalogItems.map((item) => item.id), ['a']);
      expect(state().archivedCatalogItems.map((item) => item.id), ['b']);
      expect(state().archivedCount, 1);
    });

    test('archiving moves an item across without dropping it', () async {
      await controller().onInit();

      await controller().archiveCatalogItem(active);

      verify(catalogItemRepository.archive('a')).called(1);
      expect(state().catalogItems, hasLength(2));
      expect(state().activeCatalogItems, isEmpty);
      expect(state().archivedCount, 2);
    });

    test('restoring clears the stamp', () async {
      await controller().onInit();

      await controller().restoreCatalogItem(archived);

      verify(catalogItemRepository.restore('b')).called(1);
      expect(state().activeCatalogItems.map((item) => item.id), ['a', 'b']);
      expect(state().archivedCount, 0);
    });

    test('restoring is refused when an active item holds the name', () async {
      when(catalogItemRepository.get(any)).thenAnswer(
        (_) async => [
          active.copyWith(name: 'Pedicure'),
          archived,
        ],
      );
      await controller().onInit();

      await controller().restoreCatalogItem(archived);

      expect(state().status, BaseStateStatus.error);
      verifyNever(catalogItemRepository.restore(any));
    });

    test('a catalog of nothing but archived items reads as empty', () async {
      when(catalogItemRepository.get(any)).thenAnswer((_) async => [archived]);

      await controller().onInit();

      expect(state().status, BaseStateStatus.noData);
      expect(state().archivedCount, 1);
    });
  });

  group('duplicate names', () {
    final active = catalogItemMock.copyWith(id: 'a', name: 'Depilação');
    final archived = catalogItemMock.copyWith(
      id: 'b',
      name: 'Massagem',
      archivedAt: DateTime(2026, 8, 12),
    );

    setUp(() {
      when(
        catalogItemRepository.get(any),
      ).thenAnswer((_) async => [active, archived]);
      when(catalogItemRepository.restore(any)).thenAnswer((_) async {});
    });

    test('refuses a name differing only in case and accents', () async {
      await controller().onInit();
      controller().changeCatalogItemName('  DEPILACAO  ');

      await controller().addCatalogItem();

      expect(state().status, BaseStateStatus.error);
      verifyNever(catalogItemRepository.add(any));
    });

    test('offers to restore when the name belongs to an archived item', () async {
      await controller().onInit();
      controller().changeCatalogItemName('massagem');

      await controller().addCatalogItem();

      expect(state().archivedCollision?.id, 'b');
      expect(state().status, isNot(BaseStateStatus.error));
      verifyNever(catalogItemRepository.add(any));
    });

    test('dismissing the offer clears it', () async {
      await controller().onInit();
      controller().changeCatalogItemName('massagem');
      await controller().addCatalogItem();

      controller().dismissArchivedCollision();

      expect(state().archivedCollision, isNull);
    });

    // What the form reads to raise the error under the field and hold the save
    // button dark, before anything reaches the repository.
    test('nameCollision names the active item holding the name', () async {
      await controller().onInit();

      controller().changeCatalogItemName('  DEPILACAO  ');

      expect(state().nameCollision?.id, 'a');
    });

    test('an item being edited does not collide with itself', () async {
      await controller().onInit();

      controller().changeCatalogItem(active);

      expect(state().nameCollision, isNull);
    });

    test('an archived namesake is not a collision', () async {
      await controller().onInit();

      controller().changeCatalogItemName('massagem');

      expect(state().nameCollision, isNull);
    });

    test('an unused name still creates', () async {
      await controller().onInit();
      controller().changeCatalogItemName('Corte');

      await controller().addCatalogItem();

      expect(state().archivedCollision, isNull);
      verify(catalogItemRepository.add(any)).called(1);
    });
  });

  group('search', () {
    setUp(() {
      when(catalogItemRepository.get(any)).thenAnswer(
        (_) async => [
          catalogItemMock.copyWith(id: 'a', name: 'Manicure'),
          catalogItemMock.copyWith(id: 'b', name: 'Pedicure'),
          catalogItemMock.copyWith(
            id: 'c',
            name: 'Blindagem',
            archivedAt: DateTime(2026, 8, 12),
          ),
        ],
      );
    });

    test('the term narrows the list, ignoring case and accents', () async {
      await controller().onInit();

      controller().onSearch('  PEDI  ');

      expect(state().visibleCatalogItems.map((item) => item.id), ['b']);
      expect(state().isSearchEmpty, isFalse);
    });

    test('a term matching nothing active is a search-empty, not a filter one', () async {
      await controller().onInit();

      controller().onSearch('blindagem');

      expect(state().isSearchEmpty, isTrue);
      expect(state().isFilteredEmpty, isFalse);
      // The archived item the term did find, offered back rather than
      // recreated.
      expect(state().archivedMatching.map((item) => item.id), ['c']);
    });

    test('closing the search drops the term with it', () async {
      await controller().onInit();
      controller().onOpenSearch();
      controller().onSearch('pedi');

      controller().onCloseSearch();

      expect(state().isSearching, isFalse);
      expect(state().query, isEmpty);
      expect(state().visibleCatalogItems, hasLength(2));
    });
  });

  group('freemium counting', () {
    test('archived items still occupy a slot', () async {
      // Otherwise archiving would be an unlimited way around the free tier.
      final archived = catalogItemMock.copyWith(
        id: 'b',
        name: 'Pedicure',
        archivedAt: DateTime(2026, 8, 12),
      );
      when(catalogItemRepository.get(any)).thenAnswer(
        (_) async => [catalogItemMock.copyWith(id: 'a', name: 'Manicure'), archived],
      );

      await controller().onInit();

      // The gate is handed `catalogItems.length`, which is what must include
      // the archived ones.
      expect(state().catalogItems.length, 2);
      expect(state().activeCatalogItems.length, 1);
    });
  });
}
