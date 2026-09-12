import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kazi/core/services/data/analytics/analytics_route_reporter.dart';
import 'package:kazi/core/widgets/tap_heatmap_listener.dart';
import 'package:kazi/features/settings/settings.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:posthog_flutter/posthog_flutter.dart';

final _inAppReviewStartupProvider = FutureProvider<void>((ref) async {
  final manager = await ref.watch(inAppReviewManagerProvider.future);
  await manager.onAppStarted();
});

/// Keeps the subscription identity in sync with auth so purchases follow
/// the signed-in user (and trial eligibility stays "once per user").
final _subscriptionSyncProvider = Provider<void>((ref) {
  final authService = ref.watch(authServiceProvider);
  final subscription = ref.watch(subscriptionServiceProvider);
  final subscriptionEvents = authService.userChanges().listen((user) {
    if (user != null) {
      subscription.logIn(user.uid);
    } else {
      subscription.logOut();
    }
  });
  ref.onDispose(subscriptionEvents.cancel);
});

/// Re-evaluates the currency migration whenever the signed-in user changes.
///
/// main.dart only resolves it once, before the first frame. Without this a
/// second user signing in during the same session would land on the home screen
/// with the first user's answer — or none at all.
final _currencyMigrationSyncProvider = Provider<void>((ref) {
  final authService = ref.watch(authServiceProvider);
  final authEvents = authService.userChanges().listen((_) {
    ref.read(currencyMigrationControllerProvider.notifier).check();
  });
  ref.onDispose(authEvents.cancel);
});

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Not in the bootstrap: the reporter depends on the router, whose notifier
    // waits on the bootstrap. By the time this builds the router is resolved.
    ref.watch(analyticsRouteReporterProvider);
    ref.watch(_inAppReviewStartupProvider);
    ref.watch(_subscriptionSyncProvider);
    ref.watch(_currencyMigrationSyncProvider);
    final overrideLocale = ref
        .watch(kaziLocaleControllerProvider)
        .asData
        ?.value;
    final themeMode =
        ref.watch(kaziThemeControllerProvider).asData?.value ??
        ThemeMode.system;
    final router = ref.watch(kaziRouterProvider);
    final localeResolutionCallback = ref.watch(
      kaziLocaleResolutionCallbackProvider,
    );
    // Gives the replay SDK a subtree to screenshot; without it a recording
    // comes out blank. Captures nothing until the bootstrap says so.
    return PostHogWidget(
      child: MaterialApp.router(
        title: 'Kazi',
        debugShowCheckedModeBanner: false,
        theme: KaziThemeSettings.light(),
        darkTheme: KaziThemeSettings.dark(),
        themeMode: themeMode,
        localizationsDelegates: const [
          KaziLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: KaziLocalizations.delegate.supportedLocales,
        locale: overrideLocale,
        localeResolutionCallback: localeResolutionCallback,
        routerConfig: router,
        builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: context.colors.overlayOn(context.colors.background),
          child: TapHeatmapListener(child: child!),
        ),
      ),
    );
  }
}
