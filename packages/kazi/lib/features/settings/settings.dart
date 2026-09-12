import 'package:flutter/foundation.dart';
import 'package:kazi/features/onboarding/presenter/pages/how_to_use_page.dart';
import 'package:kazi/features/services/services.dart';
import 'package:kazi/features/settings/presenter/pages/billing_cycle_page.dart';
import 'package:kazi/features/settings/presenter/pages/currency_migration_page.dart';
import 'package:kazi/features/settings/presenter/pages/privacy_policy_page.dart';
import 'package:kazi/features/settings/presenter/pages/settings_page.dart';
import 'package:kazi/features/settings/presenter/pages/tap_heatmap_page.dart';
import 'package:kazi/core/routes/app_pages.dart';
import 'package:kazi_core/kazi_core.dart';

export 'presenter/controllers/billing_cycle_controller.dart';
export 'presenter/controllers/currency_migration_controller.dart';
export 'presenter/controllers/currency_migration_state.dart';

abstract final class SettingsRoutes {
  /// The catalogue hangs off the menu — see `ServicesRoutes.serviceCatalog`.
  static GoRoute shellRoute() => GoRoute(
    path: AppPage.settings.route,
    builder: (_, _) => const SettingsPage(),
    routes: [
      ServicesRoutes.serviceCatalog,
      // Debug only: the token gallery is a development tool, not a feature.
      // Registering it conditionally keeps it out of release builds entirely
      // rather than merely hiding its entry point.
      if (kDebugMode) ...[
        GoRoute(
          path: 'design-tokens',
          builder: (_, _) => const KaziThemeGalleryPage(),
        ),
        GoRoute(
          path: 'tap-heatmap',
          builder: (_, _) => const TapHeatmapPage(),
        ),
      ],
    ],
  );

  /// Outside the shell: these must render without the bottom bar.
  static List<RouteBase> get routes => [
    // The migration gate has nowhere to navigate away to, so there must be no
    // bar to tempt it.
    GoRoute(
      path: AppPage.currencyMigration.route,
      builder: (_, _) => const CurrencyMigrationPage(),
    ),
    // A push over the menu, not a shell tab — the bottom bar has no business
    // being reachable mid-edit of the cycle that drives the home total.
    GoRoute(
      path: AppPage.billingCycle.route,
      builder: (_, _) => const BillingCyclePage(),
    ),
    GoRoute(
      path: AppPage.howToUse.route,
      builder: (_, _) => const HowToUsePage(),
    ),
    GoRoute(
      path: AppPage.privacyPolicy.route,
      builder: (_, _) => const PrivacyPolicyPage(),
    ),
  ];
}
