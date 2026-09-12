import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_policy.dart';
import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/injector.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../utils/pump_app.dart';

/// The measurement, driven through the real app.
///
/// The unit tests prove each piece behaves; this proves the pieces are actually
/// wired to the flows they claim to measure — which is the failure mode
/// analytics has, and the one nobody notices until a funnel has been empty for
/// a month.
void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  ServiceFormController formOf(TestAppHarness app) =>
      app.container.read(serviceFormControllerProvider().notifier);

  Future<void> openTheForm(WidgetTester tester, TestAppHarness app) async {
    await tester.tap(find.byIcon(Icons.format_list_bulleted));
    await settle(tester);
    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
  }

  testWidgets('every screen the person reaches is reported once', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.pump(tester);

    expect(app.fakes.analytics.screens, contains(AppPage.home.name));

    await tester.tap(find.byIcon(Icons.format_list_bulleted));
    await settle(tester);
    await tester.tap(find.byIcon(Icons.person_outline));
    await settle(tester);

    expect(app.fakes.analytics.screens, contains(AppPage.services.name));
    expect(app.fakes.analytics.screens, contains(AppPage.clients.name));

    // The delegate notifies on far more than navigation; a screen view repeated
    // on every shell rebuild would make time-on-screen meaningless.
    final home = app.fakes.analytics.screens
        .where((screen) => screen == AppPage.home.name)
        .length;
    expect(home, 1);

    // The splash is the router deciding, not a screen anybody visited.
    expect(
      app.fakes.analytics.screens,
      isNot(contains(AppPage.initial.name)),
    );
  });

  testWidgets('opening and completing the service form is measured', (
    tester,
  ) async {
    final app = TestAppHarness();
    final catalogItemId = await app.seedCatalogItem(name: 'Haircut');
    await app.pump(tester);

    await openTheForm(tester, app);
    expect(app.fakes.analytics.events, contains(AnalyticsEvent.serviceFormOpened));
    expect(
      app.fakes.analytics.screens,
      contains(AppPage.addServices.name),
      reason: 'the form is pushed over the tab, and the router delegate reports '
          'the tab underneath — so the location has to come from GoRouter.state '
          'or the app’s main bottleneck never appears in path analysis',
    );

    final types = app.container
        .read(serviceFormControllerProvider())
        .requireValue
        .catalogItems;
    final type = types.firstWhere((catalogItem) => catalogItem.id == catalogItemId);
    formOf(app)
      ..onChangeCatalogItem(DropdownItem(value: type.id, label: type.name))
      ..onChangeServiceValue(150)
      ..onChangeServiceDate(today);
    await settle(tester);

    await formOf(app).addService();
    await settle(tester);

    expect(app.fakes.analytics.events, contains(AnalyticsEvent.serviceCreated));
    expect(
      app.fakes.analytics.events,
      contains(AnalyticsEvent.firstServiceCreated),
      reason: 'the activation milestone the whole funnel converges on',
    );

    final parameters =
        app.fakes.analytics.parametersOf(AnalyticsEvent.serviceCreated)!;
    expect(parameters['quantity'], 1);
    expect(parameters['has_client'], isFalse);
    expect(
      parameters.keys,
      isNot(contains('value')),
      reason: 'shape only — never what the person earns',
    );
  });

  testWidgets('leaving the form half-filled is measured', (tester) async {
    final app = TestAppHarness();
    final catalogItemId = await app.seedCatalogItem(name: 'Haircut');
    await app.pump(tester);

    await openTheForm(tester, app);

    final types = app.container
        .read(serviceFormControllerProvider())
        .requireValue
        .catalogItems;
    final type = types.firstWhere((catalogItem) => catalogItem.id == catalogItemId);
    formOf(app).onChangeCatalogItem(
      DropdownItem(value: type.id, label: type.name),
    );
    await settle(tester);

    // Back out without saving — the case the app was entirely blind to.
    // Through the router rather than `pageBack`: the form has its own nav
    // bar, so there is no Material back button for the finder to hit.
    app.container.read(kaziRouterProvider).pop();
    await settle(tester);

    expect(
      app.fakes.analytics.events,
      contains(AnalyticsEvent.serviceFormAbandoned),
    );
    final parameters =
        app.fakes.analytics.parametersOf(AnalyticsEvent.serviceFormAbandoned)!;
    expect(parameters['last_field'], 'type');
    expect(parameters['filled_fields'], 1);
    expect(parameters['had_validation_error'], isFalse);
  });

  testWidgets('a form opened and closed untouched is not an abandonment', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Haircut');
    await app.pump(tester);

    await openTheForm(tester, app);
    app.container.read(kaziRouterProvider).pop();
    await settle(tester);

    expect(
      app.fakes.analytics.events,
      isNot(contains(AnalyticsEvent.serviceFormAbandoned)),
      reason: 'a misdirected tap would drown the real abandonments',
    );
  });

  testWidgets('hammering a button that does nothing is measured as friction', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Haircut');
    await app.pump(tester);

    await openTheForm(tester, app);

    // Save with nothing filled in: the form refuses to validate, so the button
    // never calls its own `onTap`. Hooking the callback would see none of this
    // — which is why the probe listens to the pointer instead.
    final save = find.descendant(
      of: find.byType(KaziFormFooter),
      matching: find.text(KaziLocalizations.current.registerService),
    );
    for (var tap = 0; tap < 3; tap++) {
      await tester.tap(save);
      await tester.pump();
    }
    await settle(tester);

    expect(
      app.fakes.analytics.events,
      contains(AnalyticsEvent.frictionDetected),
      reason: 'the Android half of a feature PostHog only ships on iOS',
    );
    final parameters =
        app.fakes.analytics.parametersOf(AnalyticsEvent.frictionDetected)!;
    expect(parameters['kind'], 'rage_tap');
    expect(parameters['screen'], AppPage.addServices.name);
  });

  testWidgets('hitting a freemium limit is measured before the paywall', (
    tester,
  ) async {
    final app = TestAppHarness(isPremium: false);
    final catalogItemId = await app.seedCatalogItem(name: 'Haircut');
    // Past the free monthly allowance, so the next creation is blocked.
    for (var index = 0; index < 30; index++) {
      await app.seedService(catalogItemId: catalogItemId, date: today);
    }
    await app.pump(tester);

    await openTheForm(tester, app);

    final types = app.container
        .read(serviceFormControllerProvider())
        .requireValue
        .catalogItems;
    final type = types.firstWhere((catalogItem) => catalogItem.id == catalogItemId);
    formOf(app)
      ..onChangeCatalogItem(DropdownItem(value: type.id, label: type.name))
      ..onChangeServiceValue(150)
      ..onChangeServiceDate(today);
    await settle(tester);

    await formOf(app).addService();
    await settle(tester);

    expect(app.fakes.analytics.events, contains(AnalyticsEvent.limitReached));
    expect(
      app.fakes.analytics.parametersOf(AnalyticsEvent.limitReached)!['form'],
      'service',
    );
    expect(
      app.fakes.analytics.events,
      isNot(contains(AnalyticsEvent.serviceCreated)),
      reason: 'a blocked creation is not a creation',
    );
  });

  testWidgets('a tap on a probed control carries its target and position', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Haircut');
    await app.pump(tester);

    // The bootstrap that would roll the session in is stubbed out under test.
    app.container
        .read(tapHeatmapRecorderProvider)
        .applySampling(
          const TapHeatmapPolicy.raw(
            isEnabled: true,
            samplePercent: 100,
            maxEventsPerSession: 300,
          ),
        );

    await openTheForm(tester, app);

    await tester.tap(
      find.descendant(
        of: find.byType(KaziFormFooter),
        matching: find.text(KaziLocalizations.current.registerService),
      ),
    );
    await settle(tester);

    final taps = app.fakes.analytics.logged
        .where((entry) => entry.event == AnalyticsEvent.elementTapped)
        .map((entry) => entry.parameters)
        .toList();

    expect(
      taps.map((parameters) => parameters['target']),
      contains('save_service'),
      reason: 'the probe has to reach the recorder before the root listener '
          'does, or every coordinate arrives anonymous and the map can only '
          'ever show where people touched, never what they touched',
    );

    final save = taps.firstWhere(
      (parameters) => parameters['target'] == 'save_service',
    );
    expect(save['screen'], AppPage.addServices.name);
    expect(save['x'], isA<double>());
    expect(save['y'], isA<double>());

    // Opening the form took taps of its own, and those hit no probe.
    expect(
      taps.map((parameters) => parameters['target']),
      contains('none'),
      reason: 'a tap that reached no control is the interesting half',
    );
  });
}
