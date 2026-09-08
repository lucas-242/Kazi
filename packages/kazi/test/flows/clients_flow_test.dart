import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi/features/clients/presenter/controllers/client_details_controller.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/clients/presenter/controllers/clients_controller.dart';
import 'package:kazi/features/clients/presenter/pages/client_details_page.dart';
import 'package:kazi/features/clients/presenter/pages/client_form_page.dart';
import 'package:kazi/features/clients/presenter/pages/clients_page.dart';
import 'package:kazi/features/subscription/domain/freemium_limits.dart';
import 'package:kazi/features/subscription/domain/models/user_tier.dart';
import 'package:kazi/features/subscription/presenter/widgets/paywall_view.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../utils/fakes/fake_url_launcher_service.dart';
import '../utils/pump_app.dart';

/// The clients tab end to end: list, create, open, delete.
void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  Future<void> openTheTab(WidgetTester tester, TestAppHarness app) async {
    await tester.tap(find.byIcon(Icons.person_outline));
    await settle(tester);
  }

  Future<void> openTheForm(WidgetTester tester, TestAppHarness app) async {
    await openTheTab(tester, app);
    await tester.tap(find.byType(FloatingActionButton));
    await settle(tester);
  }

  /// Types into the form's four text fields, in the order they are laid out:
  /// name, phone, e-mail, document.
  Future<void> fillForm(
    WidgetTester tester, {
    String identifier = '12345678900',
    required String name,
    String phone = '11999999999',
    String email = 'ana@test.com',
  }) async {
    // The boxed fields hold a bare TextField: KaziFieldInput is the FormField
    // around it, so the decoration and the validation are not the same widget.
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), name);
    await tester.enterText(fields.at(1), phone);
    await tester.enterText(fields.at(2), email);
    await tester.enterText(fields.at(3), identifier);
    await settle(tester);
  }

  Future<void> save(WidgetTester tester) async {
    await tester.tap(find.text(KaziLocalizations.current.save));
    await settle(tester);
  }

  testWidgets('the tab lists the clients already stored', (tester) async {
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana');
    await app.seedClient(name: 'Bruna');

    await app.pump(tester);
    await openTheTab(tester, app);

    expect(app.location, AppPage.clients.route);
    expect(find.byType(ClientsPage), findsOneWidget);
    expect(app.container.read(clientsControllerProvider).clients, hasLength(2));
    expect(find.text('Ana'), findsOneWidget);
    expect(find.text('Bruna'), findsOneWidget);
  });

  testWidgets('an empty tab says so', (tester) async {
    final app = TestAppHarness();

    await app.pump(tester);
    await openTheTab(tester, app);

    expect(find.byType(KaziEmpty), findsOneWidget);
  });

  testWidgets('the FAB opens the client form', (tester) async {
    final app = TestAppHarness();

    await app.pump(tester);
    await openTheForm(tester, app);

    expect(app.location, AppPage.addClient.route);
    expect(find.byType(ClientFormPage), findsOneWidget);
  });

  testWidgets('creating a client writes it and shows it in the list', (
    tester,
  ) async {
    final app = TestAppHarness();

    await app.pump(tester);
    await openTheForm(tester, app);
    await fillForm(tester, name: 'Ana');
    await save(tester);

    final written = await app.firestore.collection('clients').get();
    expect(written.docs, hasLength(1));
    expect(written.docs.single.data()['name'], 'Ana');
    expect(written.docs.single.data()['ownerId'], TestAppHarness.testUser.uid);

    expect(app.location, AppPage.clients.route);
    expect(
      app.container
          .read(clientsControllerProvider)
          .clients
          .single
          .info
          .user
          .name,
      'Ana',
    );
  });

  testWidgets('a client with no name is refused and nothing is written', (
    tester,
  ) async {
    final app = TestAppHarness();

    await app.pump(tester);
    await openTheForm(tester, app);
    await fillForm(tester, name: '');
    await save(tester);

    final written = await app.firestore.collection('clients').get();
    expect(written.docs, isEmpty);
    expect(app.location, AppPage.addClient.route);
  });

  testWidgets('opening a client shows its details and service history', (
    tester,
  ) async {
    final app = TestAppHarness();
    final clientId = await app.seedClient(name: 'Ana');
    final catalogItemId = await app.seedCatalogItem(name: 'Manicure');
    await app.seedService(
      catalogItemId: catalogItemId,
      catalogItemName: 'Manicure',
      date: today,
      clientId: clientId,
      clientName: 'Ana',
    );

    await app.pump(tester);
    await openTheTab(tester, app);
    await tester.tap(find.text('Ana'));
    await settle(tester);

    expect(app.location, AppPage.clientDetails.route);
    expect(find.byType(ClientDetailsPage), findsOneWidget);

    final details = app.container.read(
      clientDetailsControllerProvider(clientId: clientId),
    );
    expect(details.client?.info.user.name, 'Ana');
    expect(details.serviceHistory, hasLength(1));
    expect(details.serviceHistory.single.catalogItem?.name, 'Manicure');
  });

  testWidgets('the details show a birth date from before 2000', (tester) async {
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana', birthDate: DateTime(1990, 5, 12));

    await app.pump(tester);
    await openTheTab(tester, app);
    await tester.tap(find.text('Ana'));
    await settle(tester);

    expect(find.text(KaziLocalizations.current.birthDate), findsOneWidget);
    expect(
      find.text(DateTime(1990, 5, 12).format().normalizeDate()),
      findsOneWidget,
    );
  });

  group('contacting a client', () {
    Future<FakeUrlLauncherService> openADetailsPage(
      WidgetTester tester, {
      bool launcherSucceeds = true,
    }) async {
      final launcher = FakeUrlLauncherService(succeeds: launcherSucceeds);
      final app = TestAppHarness(
        overrides: [kaziUrlLauncherServiceProvider.overrideWithValue(launcher)],
      );
      await app.seedClient(name: 'Ana');

      await app.pump(tester);
      await openTheTab(tester, app);
      await tester.tap(find.text('Ana'));
      await settle(tester);

      return launcher;
    }

    testWidgets('tapping the email sends it straight to the mail app', (
      tester,
    ) async {
      final launcher = await openADetailsPage(tester);

      await tester.tap(find.text('client@test.com'));
      await settle(tester);

      expect(launcher.opened, ['mailto:client@test.com']);
    });

    testWidgets('tapping the phone offers a call, WhatsApp or Telegram', (
      tester,
    ) async {
      final launcher = await openADetailsPage(tester);

      await tester.tap(find.text('11999999999'));
      await settle(tester);

      final l10n = KaziLocalizations.current;
      expect(find.text(l10n.call), findsOneWidget);
      expect(find.text(l10n.whatsapp), findsOneWidget);
      expect(find.text(l10n.telegram), findsOneWidget);
      // Nothing opened until one of the three is actually chosen.
      expect(launcher.opened, isEmpty);
    });

    testWidgets('choosing to call dials the plain number', (tester) async {
      final launcher = await openADetailsPage(tester);

      await tester.tap(find.text('11999999999'));
      await settle(tester);
      await tester.tap(find.text(KaziLocalizations.current.call));
      await settle(tester);

      expect(launcher.opened, ['tel:11999999999']);
    });

    testWidgets('choosing WhatsApp opens a chat by number', (tester) async {
      final launcher = await openADetailsPage(tester);

      await tester.tap(find.text('11999999999'));
      await settle(tester);
      await tester.tap(find.text(KaziLocalizations.current.whatsapp));
      await settle(tester);

      expect(launcher.opened, ['https://wa.me/11999999999']);
    });

    testWidgets('choosing Telegram opens a chat by number, in E.164 form', (
      tester,
    ) async {
      final launcher = await openADetailsPage(tester);

      await tester.tap(find.text('11999999999'));
      await settle(tester);
      await tester.tap(find.text(KaziLocalizations.current.telegram));
      await settle(tester);

      expect(launcher.opened, ['https://t.me/+11999999999']);
    });

    testWidgets('a call the device could not place says so', (tester) async {
      await openADetailsPage(tester, launcherSucceeds: false);

      await tester.tap(find.text('11999999999'));
      await settle(tester);
      await tester.tap(find.text(KaziLocalizations.current.call));
      await settle(tester);

      expect(find.text(KaziLocalizations.current.errorToOpenApp), findsOneWidget);

      // The snackbar's own auto-dismiss timer would otherwise still be
      // pending when the test tears the widget tree down.
      await tester.pump(const Duration(seconds: 4));
    });
  });

  testWidgets('the tab header counts every client', (tester) async {
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana');
    await app.seedClient(name: 'Bruna');

    await app.pump(tester);
    await openTheTab(tester, app);

    expect(app.container.read(clientsControllerProvider).totalCount, 2);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('archiving a client drops it from the list', (tester) async {
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana');
    await app.seedClient(name: 'Bruna');

    await app.pump(tester);
    await openTheTab(tester, app);

    await tester.longPress(find.text('Ana'));
    await settle(tester);

    expect(app.container.read(clientsControllerProvider).clients, hasLength(1));
    expect(find.text('Ana'), findsNothing);
    expect(find.text('Bruna'), findsOneWidget);
  });

  testWidgets('an archived client keeps every field it had', (tester) async {
    // The whole point of archiving over the old delete: the service history
    // still points at the document, and nothing personal is wiped, so undoing
    // gives the client back intact.
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana');

    await app.pump(tester);
    await openTheTab(tester, app);
    await tester.longPress(find.text('Ana'));
    await settle(tester);

    final stored = await app.firestore.collection('clients').get();
    expect(stored.docs, hasLength(1));
    final data = stored.docs.single.data();
    expect(data['status'], ClientStatus.archived);
    expect(data['archivedAt'], isNotNull);
    expect(data['name'], 'Ana');
    expect(data['email'], 'client@test.com');
    expect(data['identifier'], '12345678900');
    expect(data['phones'], ['11999999999']);
  });

  testWidgets('undoing the archive puts the client back', (tester) async {
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana');

    await app.pump(tester);
    await openTheTab(tester, app);
    await tester.longPress(find.text('Ana'));
    await settle(tester);

    await tester.tap(find.text(KaziLocalizations.current.undo));
    await settle(tester);

    expect(app.container.read(clientsControllerProvider).clients, hasLength(1));
    expect(find.text('Ana'), findsOneWidget);
    final data = (await app.firestore.collection('clients').get()).docs.single
        .data();
    expect(data['status'], ClientStatus.active);
    expect(data.containsKey('archivedAt'), isFalse);
  });

  testWidgets('a free user at the client limit gets the paywall', (
    tester,
  ) async {
    final app = TestAppHarness(isPremium: false);
    final limit = FreemiumLimits.forTier(UserTier.newFree).maxClients;
    for (var index = 0; index < limit; index++) {
      await app.seedClient(name: 'Client $index');
    }

    await app.pump(tester);
    await openTheForm(tester, app);
    await fillForm(tester, name: 'One too many');
    await save(tester);

    expect(find.byType(PaywallView), findsOneWidget);
    final written = await app.firestore.collection('clients').get();
    expect(written.docs, hasLength(limit));
  });

  // Same shape as the catalogue: the shell's Scaffold does not resize for the
  // keyboard, so a nested one that did would leave a band of bare background
  // between the content and the keyboard.
  testWidgets('the keyboard opens no band under the content', (tester) async {
    final app = TestAppHarness();
    await app.seedClient(name: 'Ana');
    await app.pump(tester);
    await openTheTab(tester, app);

    await tester.tap(find.byIcon(Icons.search));
    await settle(tester);

    final content = find.descendant(
      of: find.byType(ClientsPage),
      matching: find.byType(KaziSafeArea),
    );
    final before = tester.getRect(content).bottom;

    tester.view.viewInsets = const FakeViewPadding(bottom: 500);
    addTearDown(tester.view.resetViewInsets);
    await settle(tester);

    expect(tester.getRect(content).bottom, before);
  });
}
