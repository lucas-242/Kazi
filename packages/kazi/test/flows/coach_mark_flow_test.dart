import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../utils/pump_app.dart';

/// The four coach marks against the real router: where each one appears, and
/// what the single slot does when two of them want the same screen.
///
/// Every other flow test runs with the hints already marked as seen, so this is
/// the only place they are exercised end to end. See `core/INTERRUPTIONS.md`.
void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  /// Enough services for the filters hint to be earned; below it its anchor is
  /// disabled. See `_hintMinimumServices` in `service_navbar.dart`.
  const enoughForFilters = 6;

  Future<TestAppHarness> boot(
    WidgetTester tester, {
    int services = enoughForFilters,
    bool isReceived = false,
  }) async {
    final app = TestAppHarness(showOnboardingOverlays: true);
    final catalogItemId = await app.seedCatalogItem(name: 'Manicure');
    for (var index = 0; index < services; index++) {
      await app.seedService(
        catalogItemId: catalogItemId,
        catalogItemName: 'Manicure',
        date: today.subtract(Duration(days: index)),
        receivedAt: isReceived ? today : null,
      );
    }

    await app.pump(tester);
    await settle(tester);
    return app;
  }

  Future<void> dismiss(WidgetTester tester) async {
    await tester.tap(find.text(KaziLocalizations.current.hintGotIt));
    await settle(tester);
  }

  Future<void> openTab(WidgetTester tester, IconData icon) async {
    await tester.tap(find.byIcon(icon));
    await settle(tester);
  }

  Future<void> openTheDetails(WidgetTester tester) async {
    await tester.tap(find.text('Manicure').first);
    await settle(tester);
  }

  // Built on demand: the localizations are only loaded once the app is pumped.
  Finder fab() => find.text(KaziLocalizations.current.hintFabTitle);
  Finder filters() => find.text(KaziLocalizations.current.hintFiltersTitle);
  Finder summary() => find.text(KaziLocalizations.current.hintSummaryTitle);
  Finder received() => find.text(KaziLocalizations.current.hintReceivedTitle);

  testWidgets('the home opens on the FAB hint', (tester) async {
    await boot(tester);

    expect(fab(), findsOneWidget);
  });

  testWidgets(
    'the services tab teaches the filters, with a history worth filtering',
    (tester) async {
      await boot(tester);
      await dismiss(tester);

      await openTab(tester, Icons.format_list_bulleted);

      expect(filters(), findsOneWidget);
    },
  );

  testWidgets('with too little history it teaches the summary instead', (
    tester,
  ) async {
    await boot(tester, services: 2);
    await dismiss(tester);

    await openTab(tester, Icons.format_list_bulleted);

    expect(filters(), findsNothing);
    expect(summary(), findsOneWidget);
  });

  testWidgets('the hint that lost the screen gets the next visit', (
    tester,
  ) async {
    await boot(tester);
    await dismiss(tester);

    await openTab(tester, Icons.format_list_bulleted);
    expect(filters(), findsOneWidget);
    await dismiss(tester);

    await openTab(tester, Icons.home_outlined);
    await openTab(tester, Icons.format_list_bulleted);

    expect(summary(), findsOneWidget);
  });

  testWidgets('the details teach the receipt stamp, in the same session', (
    tester,
  ) async {
    await boot(tester);
    await dismiss(tester);

    await openTab(tester, Icons.format_list_bulleted);
    await dismiss(tester);
    await openTheDetails(tester);

    expect(received(), findsOneWidget);
  });

  testWidgets('a service already received has nothing to teach', (
    tester,
  ) async {
    await boot(tester, isReceived: true);
    await dismiss(tester);

    await openTab(tester, Icons.format_list_bulleted);
    await dismiss(tester);
    await openTheDetails(tester);

    expect(received(), findsNothing);
  });
}
