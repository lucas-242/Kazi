import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/widgets/archived_delete_row.dart';
import 'package:kazi/core/widgets/archived_record_tile.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/presenter/controllers/catalog_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../utils/pump_app.dart';

/// The catalogue's archive, which is the only screen in the app where anything
/// is erased for good — and the one place the refusal to erase has to explain
/// itself. See `screens.html`, screen 25.
void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  Future<String> seedArchived(TestAppHarness app, String name) async {
    final doc = await app.firestore.collection('serviceTypes').add({
      ...CatalogItem(
        userId: TestAppHarness.testUser.uid,
        name: name,
        defaultValue: 100,
      ).toMap(),
      'archivedAt': Timestamp.fromDate(DateTime(2026, 8, 3)),
    });
    return doc.id;
  }

  /// Menu › catalogue › "…" › view archived.
  Future<void> openTheArchive(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.tune));
    await settle(tester);
    await tester.tap(find.text(KaziLocalizations.current.serviceCatalog));
    await settle(tester);
    await tester.tap(find.byIcon(Icons.more_horiz));
    await settle(tester);
    await tester.tap(find.text(KaziLocalizations.current.viewArchived(1)));
    await settle(tester);
  }

  testWidgets('restoring and deleting never share a row', (tester) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Manicure');
    await seedArchived(app, 'Blindagem');
    await app.pump(tester);
    await openTheArchive(tester);

    // What was put away, then — under its own heading — what may be erased.
    expect(find.byType(ArchivedRecordTile), findsOneWidget);
    expect(find.byType(ArchivedDeleteRow), findsOneWidget);
    expect(find.text(KaziLocalizations.current.archivedCatalogNote), findsOneWidget);
    expect(
      find.text(KaziLocalizations.current.deletePermanently.toUpperCase()),
      findsOneWidget,
    );
  });

  testWidgets('an item still naming services refuses to be deleted', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Manicure');
    final archivedId = await seedArchived(app, 'Blindagem');
    await app.seedService(
      catalogItemId: archivedId,
      catalogItemName: 'Blindagem',
      date: today,
    );
    await app.pump(tester);
    await openTheArchive(tester);

    await tester.tap(find.byType(ArchivedDeleteRow));
    await settle(tester);

    // The refusal carries the number, and offers the way to check it.
    expect(
      find.text(KaziLocalizations.current.cantDeleteTitle('Blindagem')),
      findsOneWidget,
    );
    expect(
      find.text(KaziLocalizations.current.seeTheServices(1)),
      findsOneWidget,
    );

    await tester.tap(find.text(KaziLocalizations.current.understood));
    await settle(tester);

    expect(
      app.container.read(catalogControllerProvider).archivedCatalogItems,
      hasLength(1),
    );
  });

  testWidgets('an item naming nothing is deleted after confirming', (
    tester,
  ) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Manicure');
    await seedArchived(app, 'Blindagem');
    await app.pump(tester);
    await openTheArchive(tester);

    await tester.tap(find.byType(ArchivedDeleteRow));
    await settle(tester);

    expect(
      find.text(KaziLocalizations.current.deleteForeverTitle('Blindagem')),
      findsOneWidget,
    );

    await tester.tap(find.text(KaziLocalizations.current.deletePermanently));
    await settle(tester);

    expect(
      app.container.read(catalogControllerProvider).archivedCatalogItems,
      isEmpty,
    );
  });

  testWidgets('restoring puts the item back in the catalogue', (tester) async {
    final app = TestAppHarness();
    await app.seedCatalogItem(name: 'Manicure');
    await seedArchived(app, 'Blindagem');
    await app.pump(tester);
    await openTheArchive(tester);

    await tester.tap(find.text(KaziLocalizations.current.restore));
    await settle(tester);

    final state = app.container.read(catalogControllerProvider);
    expect(state.archivedCatalogItems, isEmpty);
    expect(state.activeCatalogItems.map((item) => item.name), [
      'Manicure',
      'Blindagem',
    ]);
  });
}
