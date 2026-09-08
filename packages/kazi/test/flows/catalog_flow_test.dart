import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi/features/services/presenter/pages/catalog_item_form_page.dart';
import 'package:kazi/features/services/presenter/pages/service_catalog_page.dart';
import 'package:kazi/features/services/presenter/pages/service_form_page.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../utils/pump_app.dart';

/// The catalogue screen: what its two creation controls do, and what the form
/// refuses.
void main() {
  Future<TestAppHarness> openTheCatalog(
    WidgetTester tester, {
    List<String> items = const ['Manicure'],
  }) async {
    final app = TestAppHarness();
    for (final item in items) {
      await app.seedCatalogItem(name: item);
    }
    await app.pump(tester);

    await tester.tap(find.byIcon(Icons.tune));
    await settle(tester);
    await tester.tap(find.text(KaziLocalizations.current.serviceCatalog));
    await settle(tester);

    return app;
  }

  // The catalogue is the one screen that could argue for its own FAB and does
  // not get it: registering a service is the action the app is for.
  testWidgets('the FAB registers a service, not a catalogue item', (
    tester,
  ) async {
    final app = await openTheCatalog(tester);
    expect(find.byType(ServiceCatalogPage), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);

    expect(app.location, AppPage.addServices.route);
    expect(find.byType(ServiceFormPage), findsOneWidget);
  });

  testWidgets('the "+" in the header adds a catalogue item', (tester) async {
    final app = await openTheCatalog(tester);

    await tester.tap(find.byIcon(Icons.add));
    await settle(tester);

    expect(app.location, AppPage.addCatalogItem.route);
    expect(find.byType(CatalogItemFormPage), findsOneWidget);
  });

  // The summary by type sums by item, so two rows with one name would split
  // that number in two — the form says so under the field and holds the save.
  testWidgets('a name already in the catalogue is refused in the form', (
    tester,
  ) async {
    await openTheCatalog(tester);

    await tester.tap(find.byIcon(Icons.add));
    await settle(tester);
    await tester.enterText(find.byType(TextField).first, 'manicure');
    await settle(tester);

    expect(
      find.text(KaziLocalizations.current.catalogItemDuplicateName),
      findsOneWidget,
    );
    expect(
      tester
          .widget<ElevatedButton>(
            find.ancestor(
              of: find.text(KaziLocalizations.current.save),
              matching: find.byType(ElevatedButton),
            ),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('the lupa narrows the list to the term', (tester) async {
    await openTheCatalog(tester, items: ['Manicure', 'Pedicure']);

    await tester.tap(find.byIcon(Icons.search));
    await settle(tester);
    await tester.enterText(find.byType(TextField).first, 'pedi');
    await tester.pump(const Duration(milliseconds: 500));
    await settle(tester);

    expect(find.text('Pedicure'), findsOneWidget);
    expect(find.text('Manicure'), findsNothing);
  });

  // The doc's three elements: the term, the way to create it, and the archived
  // items the term did find.
  testWidgets('a term matching nothing offers to create it', (tester) async {
    final app = await openTheCatalog(tester);

    await tester.tap(find.byIcon(Icons.search));
    await settle(tester);
    await tester.enterText(find.byType(TextField).first, 'blindagem');
    await tester.pump(const Duration(milliseconds: 500));
    await settle(tester);

    expect(
      find.text(KaziLocalizations.current.nothingFoundFor('blindagem')),
      findsOneWidget,
    );

    await tester.tap(find.text(KaziLocalizations.current.createInCatalog('blindagem')));
    await settle(tester);

    expect(app.location, AppPage.addCatalogItem.route);
    // The typed term arrives in the form rather than an empty field.
    expect(find.text('blindagem'), findsWidgets);
  });

  testWidgets('an archived namesake is offered back instead', (tester) async {
    final app = await openTheCatalog(tester);
    await app.firestore.collection('serviceTypes').add({
      ...CatalogItem(
        userId: TestAppHarness.testUser.uid,
        name: 'Blindagem',
        defaultValue: 100,
      ).toMap(),
      'archivedAt': Timestamp.fromDate(DateTime(2026, 8, 3)),
    });
    await app.container.read(catalogControllerProvider.notifier).onInit();
    await settle(tester);

    await tester.tap(find.byIcon(Icons.search));
    await settle(tester);
    await tester.enterText(find.byType(TextField).first, 'blindagem');
    await tester.pump(const Duration(milliseconds: 500));
    await settle(tester);

    expect(find.text('Blindagem'), findsOneWidget);
    expect(find.text(KaziLocalizations.current.restore), findsOneWidget);
    // Something *was* found, so the screen must not say nothing was — nor
    // offer to create a second one under the same name.
    expect(
      find.text(KaziLocalizations.current.nothingFoundFor('blindagem')),
      findsNothing,
    );
    expect(
      find.text(KaziLocalizations.current.createInCatalog('blindagem')),
      findsNothing,
    );
  });

  // The screen sits inside the shell, whose own Scaffold does not resize for
  // the keyboard. A nested Scaffold that did would end its content a nav bar's
  // height above the keyboard, leaving a band of bare background between them.
  testWidgets('the keyboard opens no band under the content', (tester) async {
    await openTheCatalog(tester);
    await tester.tap(find.byIcon(Icons.search));
    await settle(tester);

    final content = find.descendant(
      of: find.byType(ServiceCatalogPage),
      matching: find.byType(KaziSafeArea),
    );
    final before = tester.getRect(content).bottom;

    tester.view.viewInsets = const FakeViewPadding(bottom: 500);
    addTearDown(tester.view.resetViewInsets);
    await settle(tester);

    expect(tester.getRect(content).bottom, before);
  });

  // Screen state 3 in the doc: the term takes the whole header, between a
  // chevron that leaves and an X that erases, and the quick filters go with it.
  testWidgets('the search takes the header, and the chips with it', (
    tester,
  ) async {
    await openTheCatalog(tester, items: ['Manicure', 'Pedicure']);
    expect(find.byType(KaziChip), findsWidgets);

    await tester.tap(find.byIcon(Icons.search));
    await settle(tester);

    expect(find.byType(KaziChip), findsNothing);
    expect(
      find.descendant(
        of: find.byType(ServiceCatalogPage),
        matching: find.byIcon(Icons.chevron_left),
      ),
      findsOneWidget,
    );
    // Nothing typed: the X would have nothing to erase.
    expect(find.byIcon(Icons.close), findsNothing);

    await tester.enterText(find.byType(TextField).first, 'pedi');
    await tester.pump(const Duration(milliseconds: 500));
    await settle(tester);
    expect(find.text('Manicure'), findsNothing);

    await tester.tap(find.byIcon(Icons.close));
    await settle(tester);

    // The term is gone and the list is whole again — but the search is still
    // open, which is what separates the X from the chevron.
    expect(find.text('Manicure'), findsOneWidget);
    expect(find.byType(KaziChip), findsNothing);
  });
}
