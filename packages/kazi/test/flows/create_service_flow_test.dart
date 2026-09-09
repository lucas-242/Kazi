import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_form_controller.dart';
import 'package:kazi/features/services/presenter/controllers/service_landing_controller.dart';
import 'package:kazi/features/services/presenter/pages/service_form_page.dart';
import 'package:kazi/features/services/presenter/pages/service_landing_page.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../utils/pump_app.dart';

/// Registering a service, from the tab to the list showing it.
///
/// The screens own the navigation and the controllers own the data, so this
/// drives the form through its controller and everything else through the UI —
/// which is the seam that actually breaks: the route, the confirm button, the
/// pop back, and the two lists that have to notice the new row.
void main() {
  // The clock is deliberately not pinned here. `Service`'s constructor
  // defaults `date` to the real `DateTime.now()` rather than going through
  // `TimeService`, so a pinned harness clock would move the list's date range
  // without moving the date the form stamps on a new service, and every
  // creation would land outside the window it is supposed to appear in.
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  /// Walks from the home tab to the service form the way a person does.
  Future<void> openTheForm(WidgetTester tester, TestAppHarness app) async {
    await tester.tap(find.byIcon(Icons.format_list_bulleted));
    await settle(tester);
    expect(app.location, AppPage.services.route);

    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
  }

  ServiceFormController formOf(TestAppHarness app) =>
      app.container.read(serviceFormControllerProvider().notifier);

  /// Picks [catalogItemId] in the form and types a value.
  ///
  /// Done through the controller rather than the widgets: the form's money and
  /// date fields are driven by masked controllers, and reproducing their
  /// keystrokes would test `flutter_masked_text2`, not this flow.
  Future<void> fillForm(
    WidgetTester tester,
    TestAppHarness app, {
    required String catalogItemId,
    double value = 150,
  }) async {
    final types = app.container
        .read(serviceFormControllerProvider())
        .requireValue
        .catalogItems;
    final type = types.firstWhere((catalogItem) => catalogItem.id == catalogItemId);
    formOf(app)
      ..onChangeCatalogItem(DropdownItem(value: type.id, label: type.name))
      // After the type, never before: picking a type resets the value to the
      // type's default.
      ..onChangeServiceValue(value);
    await settle(tester);
  }

  // Matched inside the footer, not by the button's type: the screen's title
  // carries the same words, and the bar owns which button it draws.
  Finder saveButton() => find.descendant(
    of: find.byType(KaziFormFooter),
    matching: find.text(KaziLocalizations.current.registerService),
  );

  Future<void> save(WidgetTester tester) async {
    await tester.tap(saveButton());
    await settle(tester);
  }

  testWidgets('the services tab lists what is already there', (tester) async {
    final app = TestAppHarness();
    final catalogItemId = await app.seedCatalogItem(name: 'Manicure');
    await app.seedService(
      catalogItemId: catalogItemId,
      catalogItemName: 'Manicure',
      date: today,
      value: 80,
    );

    await app.pump(tester);
    await tester.tap(find.byIcon(Icons.format_list_bulleted));
    await settle(tester);

    expect(find.byType(ServiceLandingPage), findsOneWidget);
    expect(
      app.container.read(serviceLandingControllerProvider).services,
      hasLength(1),
    );
  });

  testWidgets('the FAB opens the service form', (tester) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Manicure');

    await app.pump(tester);
    await openTheForm(tester, app);

    expect(app.location, AppPage.addServices.route);
    expect(find.byType(ServiceFormPage), findsOneWidget);
  });

  testWidgets('saving writes the service and returns to the list', (
    tester,
  ) async {
    final app = TestAppHarness();
    final catalogItemId = await app.seedCatalogItem(name: 'Manicure');

    await app.pump(tester);
    await openTheForm(tester, app);

    await fillForm(tester, app, catalogItemId: catalogItemId);
    await save(tester);

    final written = await app.firestore.collection('services').get();
    expect(written.docs, hasLength(1));
    expect(written.docs.single.data()['value'], 150);
    expect(written.docs.single.data()['typeId'], catalogItemId);

    // Back on the list, which now has the row without a refetch of its own.
    expect(app.location, AppPage.services.route);
    expect(
      app.container.read(serviceLandingControllerProvider).services,
      hasLength(1),
    );
  });

  testWidgets('the dashboard picks the new service up too', (tester) async {
    final app = TestAppHarness();
    final catalogItemId = await app.seedCatalogItem(name: 'Manicure');

    await app.pump(tester);
    expect(app.container.read(dashboardControllerProvider).services, isEmpty);

    await openTheForm(tester, app);
    await fillForm(tester, app, catalogItemId: catalogItemId);
    await save(tester);

    expect(
      app.container.read(dashboardControllerProvider).services,
      hasLength(1),
    );
  });

  testWidgets('a service with no type is refused and nothing is written', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Manicure');

    await app.pump(tester);
    await openTheForm(tester, app);

    formOf(app).onChangeServiceValue(150);
    await settle(tester);
    await save(tester);

    expect(await app.firestore.collection('services').get(), _isEmptyQuery);
    // Still on the form: a refused save must not look like a successful one.
    expect(app.location, AppPage.addServices.route);
  });

  testWidgets('a creation counts towards the interstitial cadence', (
    tester,
  ) async {
    final app = TestAppHarness();
    final catalogItemId = await app.seedCatalogItem(name: 'Manicure');

    await app.pump(tester);
    await openTheForm(tester, app);
    await fillForm(tester, app, catalogItemId: catalogItemId);
    await save(tester);

    expect(app.fakes.creationAds.creationActions, 1);
  });
}

final Matcher _isEmptyQuery = predicate(
  (query) => (query as dynamic).docs.isEmpty,
  'an empty query result',
);
