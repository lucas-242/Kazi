import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/services/data/local_time_service.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/features/auth/domain/models/app_user.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/data/services/local_service_organizer.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../../../../../mocks/mocks.dart';
import '../../../../../utils/test_helper.dart';

/// Leaving a tab abandons whatever it was fetching: the answer would land on a
/// screen nobody is looking at, and coming back asks again. See the
/// loading-scope rules in `themes/README.md`.
void main() {
  late ProviderContainer container;
  late _BlockingServicesRepository repository;

  TestHelper.loadAppLocalizations();

  setUp(() {
    repository = _BlockingServicesRepository();
    container = ProviderContainer(
      overrides: [
        servicesRepositoryProvider.overrideWithValue(repository),
        catalogItemRepositoryProvider.overrideWithValue(
          _EmptyCatalogRepository(),
        ),
        authServiceProvider.overrideWithValue(_StubAuthService()),
        serviceOrganizerProvider.overrideWithValue(
          LocalServiceOrganizer(LocalTimeService()),
        ),
        // The controller listens to it in `build`, and its real chain reaches
        // local storage — left alone it rebuilds the controller mid-read and
        // the test would be measuring that instead of the cancellation.
        kaziDefaultCurrencyProvider.overrideWithValue(SupportedCurrency.usd),
      ],
    );
    addTearDown(container.dispose);
    // Kept subscribed, the way a mounted screen keeps it: without a
    // listener the provider is torn down mid-read and the assertion would
    // be measuring the teardown, not the cancellation.
    container.listen(serviceLandingControllerProvider, (_, _) {});
    // Resolves the currency listen in `build` before any read starts, so a
    // rebuild cannot be mistaken for a cancellation.
    container.read(serviceLandingControllerProvider);
  });

  ServiceLandingController controller() =>
      container.read(serviceLandingControllerProvider.notifier);

  test('Should throw away a read that was abandoned', () async {
    final pending = controller().onInit();
    controller().cancelPendingRead();
    repository.answer([]);
    await pending;

    // Still loading: the answer arrived for a screen that had moved on, so it
    // was dropped rather than written.
    expect(
      container.read(serviceLandingControllerProvider).status,
      BaseStateStatus.loading,
    );
  });

  test('Should let the next read land', () async {
    final abandoned = controller().onInit();
    controller().cancelPendingRead();
    repository.answer([]);
    await abandoned;

    final retry = controller().onRefresh();
    repository.answer([]);
    await retry;
    await _settle();

    expect(
      container.read(serviceLandingControllerProvider).status,
      isNot(BaseStateStatus.loading),
    );
  });

  test('Should write a read nobody abandoned', () async {
    final pending = controller().onInit();
    repository.answer([]);
    await pending;
    await _settle();

    expect(
      container.read(serviceLandingControllerProvider).status,
      isNot(BaseStateStatus.loading),
    );
  });

  test('Should ask again on the way back to the tab', () async {
    final abandoned = controller().onInit();
    controller().cancelPendingRead();
    repository.answer([]);
    await abandoned;

    final resumed = controller().resumeAbandonedRead();
    repository.answer([]);
    await resumed;
    await _settle();

    expect(repository.requests, 2);
    expect(
      container.read(serviceLandingControllerProvider).status,
      isNot(BaseStateStatus.loading),
    );
  });

  // Leaving a tab that was not fetching drops nothing, so there is nothing to
  // ask for again — and a refetch per tab switch would flash the skeleton.
  test('Should not refetch on the way back when nothing was dropped', () async {
    final pending = controller().onInit();
    repository.answer([]);
    await pending;
    await _settle();

    controller().cancelPendingRead();
    await controller().resumeAbandonedRead();

    expect(repository.requests, 1);
  });
}

/// Lets the controller's fire-and-forget work settle before asserting.
Future<void> _settle() =>
    Future<void>.delayed(const Duration(milliseconds: 10));

/// Holds every read open until the test answers it, which is the only way to
/// be standing between the request and its reply.
class _BlockingServicesRepository extends Fake implements ServicesRepository {
  final _pending = <Completer<List<Service>>>[];

  int requests = 0;

  void answer(List<Service> services) => _pending.removeAt(0).complete(services);

  @override
  Future<List<Service>> get(
    String userId,
    DateTime startDate, [
    DateTime? endDate,
  ]) {
    requests++;
    final completer = Completer<List<Service>>();
    _pending.add(completer);
    return completer.future;
  }
}

class _EmptyCatalogRepository extends Fake implements CatalogItemRepository {
  @override
  Future<List<CatalogItem>> get(String userId) async => const [];
}

class _StubAuthService extends Fake implements AuthService {
  @override
  AppUser? get user => userMock;
}
