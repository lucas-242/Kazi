import 'dart:async';

import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/core/utils/base_notifier.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/utils/date_range.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/domain/models/service.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/services/domain/services/service_organizer.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/settings/presenter/controllers/billing_cycle_controller.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItemRepository, CatalogItem;

import 'dashboard_state.dart';

part 'dashboard_controller.g.dart';

/// A resolved pay cycle: the window to fetch, and how long until it pays out.
typedef _CycleWindow = ({DateRange range, int daysUntilClose});

@Riverpod(keepAlive: true)
class DashboardController extends _$DashboardController
    with BaseNotifier<DashboardState> {
  ServicesRepository get _serviceProvidedRepository =>
      ref.read(servicesRepositoryProvider);

  CatalogItemRepository get _catalogItemRepository =>
      ref.read(catalogItemRepositoryProvider);

  AuthService get _authService => ref.read(authServiceProvider);

  ServiceOrganizer get _serviceOrganizer => ref.read(serviceOrganizerProvider);

  @override
  DashboardState build() {
    // Recompute totals when the user switches their profile default currency.
    ref.listen(kaziDefaultCurrencyProvider, (_, next) {
      state = state.copyWith(defaultCurrency: next);
    });

    // Refetch when the pay cycle changes: the window moved. Compares resolved
    // values, not the AsyncValues, so the cold-start loading -> data
    // transition does not fire a second fetch on top of onInit's.
    ref.listen(billingCycleControllerProvider, (previous, next) {
      final before = previous?.asData?.value;
      final after = next.asData?.value;
      if (before != null && after != null && before != after) onRefresh();
    });

    return DashboardState(
      status: BaseStateStatus.loading,
      defaultCurrency: ref.read(kaziDefaultCurrencyProvider),
    );
  }

  Future<void> onInit() async {
    final generation = _readGeneration;
    _readsInFlight++;
    try {
      final window = await _currentWindow();
      final result = await Future.wait<dynamic>([
        _getCatalogItems(),
        _getServices(window.range),
      ]);
      if (generation != _readGeneration) return;

      await _handleServices(result[1], result[0], window);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    } finally {
      _readsInFlight--;
    }
  }

  Future<List<CatalogItem>> _getCatalogItems() async {
    final result = await _catalogItemRepository.get(_authService.user!.uid);
    return result;
  }

  /// The window the home reports on, from the user's configured pay cycle.
  ///
  /// Awaited rather than read through [billingCycleProvider]'s synchronous
  /// fallback, which would fetch the calendar month on every cold start and
  /// then correct itself — a flash of the wrong number. See README.md.
  Future<_CycleWindow> _currentWindow() async {
    final cycle = await ref.read(billingCycleControllerProvider.future);
    final now = _serviceOrganizer.now;

    return (
      range: cycle.currentCycle(now),
      daysUntilClose: cycle.daysUntilClose(now),
    );
  }

  /// The cycle's services: the home reports the cycle's totals and slices today
  /// out of the same list, so a single query serves both.
  Future<List<Service>> _getServices(DateRange range) async {
    final result = await _serviceProvidedRepository.get(
      _authService.user!.uid,
      range.start,
      range.end,
    );
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
      final window = await _currentWindow();
      final result = await Future.wait<dynamic>([
        _getCatalogItems(),
        _getServices(window.range),
      ]);
      if (generation != _readGeneration) return;
      await _handleServices(result[1], result[0], window);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    } finally {
      _readsInFlight--;
    }
  }

  Future<void> _handleServices(
    List<Service> services,
    List<CatalogItem> items,
    _CycleWindow window,
  ) async {
    try {
      // The catalogue is fetched here for the service names; handing it to the
      // shared controller is what lets the menu report the item count without
      // a query of its own.
      ref.read(catalogControllerProvider.notifier).seed(items);

      var newServices = _serviceOrganizer.addCatalogItemToServices(
        services,
        items,
      );

      // Rates first: ordering by value and summing both need every service
      // expressed in the same currency.
      final rateBook = await _loadRateBook(newServices);

      newServices = _serviceOrganizer.orderServices(
        newServices,
        state.selectedOrderBy,
        currency: state.defaultCurrency,
        rateBook: rateBook,
      );

      final newStatus = services.isEmpty
          ? BaseStateStatus.noData
          : BaseStateStatus.success;

      state = state.copyWith(
        status: newStatus,
        services: newServices,
        rateBook: rateBook,
        referenceDate: _serviceOrganizer.now,
        cycleRange: window.range,
        daysUntilClose: window.daysUntilClose,
      );

      _reportView(hasData: services.isNotEmpty);
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }

  /// Guarded because it runs inside the same `try` that decides whether the
  /// home renders: measuring the view must not turn it into an error state.
  void _reportView({required bool hasData}) {
    try {
      _report(hasData: hasData);
    } catch (exception) {
      Log.error('Failed to report dashboard view: $exception');
    }
  }

  void _report({required bool hasData}) {
    final analytics = ref.read(analyticsServiceProvider);
    final totals = state.totals;

    unawaited(
      analytics.log(
        AnalyticsEvent.dashboardViewed,
        parameters: {
          'has_data': hasData,
          'services_bucket': _bucket(state.services.length),
          'unconverted_count': totals.unconverted,
        },
      ),
    );

    // Its own event: an empty home on a returning session is the strongest
    // churn signal the app has, and a screen view cannot distinguish it.
    if (!hasData) {
      unawaited(analytics.log(AnalyticsEvent.dashboardEmptyStateSeen));
    }

    // The exchange-rate degradation the app is otherwise silent about.
    if (totals.isPartial) {
      unawaited(
        analytics.log(
          AnalyticsEvent.ratesUnavailable,
          parameters: {'context': 'totals', 'count': totals.unconverted},
        ),
      );
    }
  }

  /// Bucketed, never exact — an exact count publishes the size of somebody's
  /// business.
  static String _bucket(int count) => switch (count) {
    0 => '0',
    < 5 => '1-4',
    < 20 => '5-19',
    < 50 => '20-49',
    _ => '50+',
  };

  /// Applies payment stamps already written by `ServiceReceiptController`,
  /// patching the in-memory list instead of refetching. Ids not on screen are
  /// ignored, so the same call can be broadcast to every list.
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
}
