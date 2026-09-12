import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/constants/storage_keys.dart';
import 'package:kazi/core/routes/app_router.dart';
import 'package:kazi/core/services/data/analytics/analytics_route_reporter.dart';
import 'package:kazi/core/widgets/tap_heatmap_listener.dart';
import 'package:kazi/features/auth/data/services/kazi_firebase_auth_service.dart';
import 'package:kazi/features/auth/domain/models/app_user.dart';
import 'package:kazi/features/clients/data/repositories/models/firebase_client_model.dart';
import 'package:kazi/features/clients/domain/models/client_entry.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/services/data/repositories/models/firebase_service_model.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import 'fakes/fake_auth_service.dart';
import 'test_helper.dart';
import 'test_overrides.dart';

/// Advances a bounded number of frames.
///
/// `pumpAndSettle` is unusable in these flows: every loading state renders a
/// `CircularProgressIndicator`, whose animation never completes, so settling
/// never terminates and the test hangs until the 10-minute timeout.
Future<void> settle(
  WidgetTester tester, {
  int frames = 12,
  Duration step = const Duration(milliseconds: 100),
}) async {
  for (var frame = 0; frame < frames; frame++) {
    await tester.pump(step);
  }
}

/// The whole app — real router, real redirects, real controllers — with every
/// external dependency faked.
///
/// This is what the `test/flows/` tests drive. It mirrors the
/// `ProviderContainer` built in `main.dart`; the differences are the two
/// overrides marked below, each of which would otherwise reach a platform
/// channel that does not exist under `flutter test`.
class TestAppHarness {
  TestAppHarness({
    this.signedIn = true,
    this.isPremium = true,
    this.onboardingCompleted = true,
    this.forcedUpdateRequired = false,
    this.currencyMigrationRequired = false,
    this.routerConfig,
    this.showOnboardingOverlays = false,
    this.surfaceSize = const Size(420, 950),
    DateTime? now,
    List<Override> overrides = const [],
  }) : _extraOverrides = overrides {
    fakes = TestFakes(
      auth: FakeAuthService(user: signedIn ? testUser : null),
      isPremium: isPremium,
      // Today, not the fixed date the unit-test fakes use. `Service`'s
      // constructor defaults `date` to the real `DateTime.now()` instead of
      // going through `TimeService`, so a pinned clock moves the list's date
      // window without moving the date a new service is stamped with, and
      // every creation lands outside the window it should appear in.
      now: now ?? DateTime.now(),
    );
    if (!showOnboardingOverlays) _markOverlaysSeen();
  }

  /// Marks every coach mark and the release announcement as already seen.
  ///
  /// Without this the first frame of the home tab raises the FAB coach mark,
  /// which covers the screen with a barrier — every subsequent `tap` silently
  /// misses and the flow appears to do nothing. A flow about creating a service
  /// should not also be a test of the hint that points at the button.
  void _markOverlaysSeen() {
    for (final hint in OnboardingHint.values) {
      fakes.storage.values[hint.storageKey] = true;
    }
    fakes.storage.values[StorageKeys.whatsNewSeenVersion] =
        fakes.appInfo.version;
  }

  /// The signed-in user every seeded document belongs to.
  static final testUser = AppUser(
    uid: 'test-uid',
    name: 'Test User',
    email: 'test@test.com',
  );

  final bool signedIn;
  final bool isPremium;
  final bool onboardingCompleted;
  final bool forcedUpdateRequired;
  final bool currencyMigrationRequired;

  /// Defaults to the app's real routing table. Only a test that needs to
  /// isolate the redirect logic from the screens should replace it.
  final KaziRouterConfig? routerConfig;

  /// Whether coach marks and the release announcement may appear. Off by
  /// default — see [_markOverlaysSeen].
  final bool showOnboardingOverlays;

  /// Logical size of the test surface.
  ///
  /// A phone, not flutter_test's 800x600 default: these screens scroll, and on
  /// a short surface the confirm button of every form sits below the fold,
  /// where `tap` silently misses it.
  final Size surfaceSize;

  final List<Override> _extraOverrides;

  late final TestFakes fakes;
  late final ProviderContainer container;

  FakeFirebaseFirestore get firestore => fakes.firestore;
  FakeAuthService get auth => fakes.auth;

  /// The location the router currently shows, including routes reached by
  /// `push` rather than `go`.
  ///
  /// Read from `GoRouter.state`, not `routerDelegate.currentConfiguration`:
  /// the latter reports the last *declarative* match, so every full-screen
  /// route the app pushes onto the root navigator (the service form, the
  /// client form, the details screens) would read as the tab underneath it.
  String get location => container.read(kaziRouterProvider).state.uri.path;

  /// Writes a service type owned by [testUser] and returns its document id.
  ///
  /// Seeding goes straight to the fake Firestore rather than through the
  /// repositories, so a test that is about reading is not also asserting the
  /// write path.
  Future<String> seedCatalogItem({
    required String name,
    double defaultValue = 100,
    double? commissionPercent,
    String color = '',
    String currency = '',
  }) async {
    final doc = await firestore
        .collection('serviceTypes')
        .add(
          CatalogItem(
            userId: testUser.uid,
            name: name,
            defaultValue: defaultValue,
            commissionPercent: commissionPercent,
            color: color,
            currency: currency,
          ).toMap(),
        );
    return doc.id;
  }

  /// Writes a service owned by [testUser] and returns its document id.
  Future<String> seedService({
    required String catalogItemId,
    required DateTime date,
    String catalogItemName = 'Service',
    double value = 100,
    double commissionPercent = 100,
    String description = '',
    String? clientId,
    String? clientName,
    String currency = 'USD',
    DateTime? receivedAt,
  }) async {
    final doc = await firestore.collection('services').add({
      ...FirebaseServiceModel(
        userId: testUser.uid,
        catalogItemId: catalogItemId,
        catalogItem: CatalogItem(
          userId: testUser.uid,
          name: catalogItemName,
          defaultValue: value,
        ),
        date: date,
        value: value,
        commissionPercent: commissionPercent,
        description: description,
        clientId: clientId,
        clientName: clientName,
        currency: currency,
        receivedAt: receivedAt,
      ).toMap(),
      // Written by the repository, not by `toMap`, and read by the freemium
      // month counter.
      'createdAt': Timestamp.fromDate(date),
    });
    return doc.id;
  }

  /// Writes a client owned by [testUser] and returns its document id.
  Future<String> seedClient({
    required String name,
    String email = 'client@test.com',
    List<String> phones = const ['11999999999'],
    String identifier = '12345678900',
    DateTime? birthDate,
  }) async {
    final doc = await firestore
        .collection('clients')
        .add(
          FirebaseClientModel.toMap(
            testUser.uid,
            User(
              id: 0,
              name: name,
              email: email,
              phones: phones,
              document: identifier,
              birthDate: birthDate ?? ClientBirthDate.missing,
              userType: UserType.client,
              authToken: '',
              refreshToken: '',
              authExpires: DateTime(2100),
            ),
          ),
        );
    return doc.id;
  }

  Future<void> pump(WidgetTester tester) async {
    await TestHelper.loadAppLocalizations();

    container = ProviderContainer(
      overrides: [
        ...fakes.overrides,

        // Mirrors main.dart.
        kaziAuthServiceProvider.overrideWith(
          (ref) => KaziFirebaseAuthService(ref.watch(authServiceProvider)),
        ),
        kaziRouterConfigProvider.overrideWith(
          (ref) => routerConfig ?? AppRouter.config(),
        ),
        kaziForcedUpdateRequiredProvider.overrideWith(
          (ref) => forcedUpdateRequired,
        ),
        kaziCurrencyMigrationRequiredProvider.overrideWith(
          (ref) => currencyMigrationRequired,
        ),
        kaziOnboardingCompletedProvider.overrideWith(
          (ref) async => onboardingCompleted,
        ),

        // Differs from main.dart, deliberately:
        // 1800ms of branded splash is 1800ms added to every flow test.
        kaziMinimumSplashDurationProvider.overrideWithValue(Duration.zero),
        // The real `appBootstrapProvider` calls `MobileAds.instance.initialize()`,
        // which needs a platform channel. Its own fail-open behaviour is
        // covered by `test/lib/core/bootstrap_test.dart` instead.
        kaziAppBootstrapProvider.overrideWith((ref) async {}),

        ..._extraOverrides,
      ],
    );
    // Order matters, and `addTearDown` is LIFO: the container has to go first.
    // Closing the auth stream while the router's subscription is still open
    // leaves that cancellation waiting on a generator that will never resume,
    // and the test hangs in teardown rather than failing.
    addTearDown(fakes.dispose);
    addTearDown(container.dispose);

    tester.view.physicalSize = surfaceSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(container: container),
      ),
    );
    await settle(tester);
  }
}

/// `App` minus the three startup side-effect providers it watches (in-app
/// review, subscription identity sync, currency-migration recheck). They are
/// startup wiring, not routing, and each is covered by its own unit test.
class _TestApp extends ConsumerWidget {
  const _TestApp({required this.container});

  final ProviderContainer container;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kept from `App`, unlike the three startup providers above: it is a
    // keepAlive listener nothing else subscribes to, so dropping it would leave
    // screen views silently unemitted — and a flow test could not tell that
    // apart from them being emitted wrongly.
    ref.watch(analyticsRouteReporterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: KaziThemeSettings.light(),
      darkTheme: KaziThemeSettings.dark(),
      localizationsDelegates: const [
        KaziLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: KaziLocalizations.delegate.supportedLocales,
      locale: const Locale('en'),
      routerConfig: ref.watch(kaziRouterProvider),
      builder: (context, child) => TapHeatmapListener(child: child!),
    );
  }
}
