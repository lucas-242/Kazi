import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:kazi/core/counters/counters_backfill.dart';
import 'package:kazi/core/currency/firebase_exchange_rate_history_repository.dart';
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/services/data/ads/admob_interstitial_ad_service.dart';
import 'package:kazi/core/services/data/ads/banner_ad_policy.dart';
import 'package:kazi/core/services/data/ads/creation_ad_coordinator.dart';
import 'package:kazi/core/services/data/analytics/analytics_bootstrap.dart';
import 'package:kazi/core/services/data/analytics/composite_analytics_service.dart';
import 'package:kazi/core/services/data/analytics/firebase_analytics_service.dart';
import 'package:kazi/core/services/data/analytics/friction_detector.dart';
import 'package:kazi/core/services/data/analytics/posthog_analytics_service.dart';
import 'package:kazi/core/services/data/analytics/session_replay_policy.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_policy.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_recorder.dart';
import 'package:kazi/core/services/data/crashlytics/firebase_crashlytics_service.dart';
import 'package:kazi/core/services/data/local_time_service.dart';
import 'package:kazi/core/services/data/remote_config_feature_flag_service.dart';
import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/core/services/domain/analytics_service.dart';
import 'package:kazi/core/services/domain/crashlytics_service.dart';
import 'package:kazi/core/services/domain/feature_flag.dart';
import 'package:kazi/core/services/domain/feature_flag_service.dart';
import 'package:kazi/core/services/domain/interstitial_ad_service.dart';
import 'package:kazi/core/services/domain/time_service.dart';
import 'package:kazi/features/app_update/data/services/remote_config_app_update_service.dart';
import 'package:kazi/features/app_update/domain/services/app_update_service.dart';
import 'package:kazi/features/auth/data/services/firebase_auth_service.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/clients/data/repositories/firebase_clients_repository.dart';
import 'package:kazi/features/clients/domain/repositories/clients_repository.dart';
import 'package:kazi/features/services/data/repositories/firebase_catalog_item_repository.dart';
import 'package:kazi/features/services/data/repositories/firebase_services_repository.dart';
import 'package:kazi/features/services/data/services/local_service_organizer.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/services/domain/services/service_organizer.dart';
import 'package:kazi/features/settings/data/repositories/firebase_currency_migration_repository.dart';
import 'package:kazi/features/settings/data/repositories/firebase_user_settings_repository.dart';
import 'package:kazi/features/settings/data/user_document_currency_store.dart';
import 'package:kazi/features/settings/domain/repositories/currency_migration_repository.dart';
import 'package:kazi/features/settings/domain/repositories/user_settings_repository.dart';
import 'package:kazi/features/settings/presenter/controllers/privacy_controller.dart';
import 'package:kazi/features/subscription/data/services/revenue_cat_subscription_service.dart';
import 'package:kazi/features/subscription/domain/freemium_guard.dart';
import 'package:kazi/features/subscription/domain/models/entitlement.dart';
import 'package:kazi/features/subscription/domain/services/subscription_service.dart';
import 'package:kazi_core/kazi_core.dart' hide CatalogItemRepository;
import 'package:posthog_flutter/posthog_flutter.dart';

part 'injector.g.dart';

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(Ref ref) => FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
CrashlyticsService crashlyticsService(Ref ref) =>
    FirebaseCrashlyticsService(FirebaseCrashlytics.instance);

@Riverpod(keepAlive: true)
FirebaseAnalyticsService firebaseAnalyticsSink(Ref ref) =>
    FirebaseAnalyticsService(
      () => FirebaseAnalytics.instance,
      ref.watch(crashlyticsServiceProvider),
    );

@Riverpod(keepAlive: true)
PostHogAnalyticsService postHogAnalyticsSink(Ref ref) =>
    PostHogAnalyticsService(Posthog(), ref.watch(crashlyticsServiceProvider));

/// The only analytics dependency anything outside `core/services` should read.
/// It fans out to both sinks and applies the consent switch; see
/// [CompositeAnalyticsService].
@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) => CompositeAnalyticsService(
  firebase: ref.watch(firebaseAnalyticsSinkProvider),
  postHog: ref.watch(postHogAnalyticsSinkProvider),
  // `read`, not `watch`, and evaluated per call: watching would rebuild the
  // service — and every controller holding it — each time the answer flips.
  isEnabled: () => ref.read(isAnalyticsAllowedProvider),
);

@Riverpod(keepAlive: true)
SessionReplayPolicy sessionReplayPolicy(Ref ref) =>
    SessionReplayPolicy(remoteConfig: ref.watch(firebaseRemoteConfigProvider));

@Riverpod(keepAlive: true)
TapHeatmapPolicy tapHeatmapPolicy(Ref ref) =>
    TapHeatmapPolicy(remoteConfig: ref.watch(firebaseRemoteConfigProvider));

@Riverpod(keepAlive: true)
TapHeatmapRecorder tapHeatmapRecorder(Ref ref) => TapHeatmapRecorder(
  onCapture: (parameters) => unawaited(
    ref
        .read(analyticsServiceProvider)
        .log(AnalyticsEvent.elementTapped, parameters: parameters),
  ),
);

@Riverpod(keepAlive: true)
AnalyticsBootstrap analyticsBootstrap(Ref ref) => AnalyticsBootstrap(
  firebase: ref.watch(firebaseAnalyticsSinkProvider),
  postHog: ref.watch(postHogAnalyticsSinkProvider),
);

/// Recognises a person struggling and promotes the session to being recorded.
/// Reports the event itself, so call sites only push the raw signal in.
@Riverpod(keepAlive: true)
FrictionDetector frictionDetector(Ref ref) => FrictionDetector(
  now: () => ref.read(timeServiceProvider).now,
  onDetected: (kind, screen, occurrences) {
    unawaited(
      ref
          .read(analyticsServiceProvider)
          .log(
            AnalyticsEvent.frictionDetected,
            parameters: {
              'kind': kind.name,
              'screen': screen,
              'count': occurrences,
            },
          ),
    );
    unawaited(
      ref
          .read(analyticsBootstrapProvider)
          .promoteForFriction(policy: ref.read(sessionReplayPolicyProvider)),
    );
  },
);

@Riverpod()
TimeService timeService(Ref ref) => LocalTimeService();

@Riverpod()
ServiceOrganizer serviceOrganizer(Ref ref) =>
    LocalServiceOrganizer(ref.watch(timeServiceProvider));

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) => FirebaseAuthService(
  crashlyticsService: ref.watch(crashlyticsServiceProvider),
);

@Riverpod()
ServicesRepository servicesRepository(Ref ref) => FirebaseServicesRepository(
  ref.watch(firebaseFirestoreProvider),
  ref.watch(crashlyticsServiceProvider),
);

/// Repairs the denormalized counters from the services themselves. Runs once
/// per account, in the background; see `core/counters.md`.
@Riverpod(keepAlive: true)
CountersBackfill countersBackfill(Ref ref) => CountersBackfill(
  ref.watch(firebaseFirestoreProvider),
  ref.watch(crashlyticsServiceProvider),
);

@Riverpod()
ClientsRepository clientsRepository(Ref ref) => FirebaseClientsRepository(
  ref.watch(firebaseFirestoreProvider),
  ref.watch(crashlyticsServiceProvider),
);

@Riverpod()
CatalogItemRepository catalogItemRepository(Ref ref) =>
    FirebaseCatalogItemRepository(
      ref.watch(firebaseFirestoreProvider),
      ref.watch(crashlyticsServiceProvider),
    );

@Riverpod()
UserSettingsRepository userSettingsRepository(Ref ref) =>
    FirebaseUserSettingsRepository(
      ref.watch(firebaseFirestoreProvider),
      ref.watch(crashlyticsServiceProvider),
    );

@Riverpod()
CurrencyMigrationRepository currencyMigrationRepository(Ref ref) =>
    FirebaseCurrencyMigrationRepository(
      ref.watch(firebaseFirestoreProvider),
      ref.watch(crashlyticsServiceProvider),
    );

@Riverpod()
KaziRemoteCurrencyStore appRemoteCurrencyStore(Ref ref) =>
    UserDocumentCurrencyStore(
      repository: ref.watch(userSettingsRepositoryProvider),
      authService: ref.watch(authServiceProvider),
    );

@Riverpod()
ExchangeRateHistoryRepository appExchangeRateHistoryRepository(Ref ref) =>
    FirebaseExchangeRateHistoryRepository(ref.watch(firebaseFirestoreProvider));

@Riverpod(keepAlive: true)
FirebaseRemoteConfig firebaseRemoteConfig(Ref ref) =>
    FirebaseRemoteConfig.instance;

@Riverpod(keepAlive: true)
FeatureFlagService featureFlagService(Ref ref) =>
    RemoteConfigFeatureFlagService(
      ref.watch(firebaseRemoteConfigProvider),
      ref.watch(crashlyticsServiceProvider),
    );

@Riverpod(keepAlive: true)
bool isPaymentsEnabled(Ref ref) =>
    ref.watch(featureFlagServiceProvider).isEnabled(FeatureFlag.payments);

@Riverpod()
AppUpdateService appUpdateService(Ref ref) => RemoteConfigAppUpdateService(
  ref.watch(firebaseRemoteConfigProvider),
  ref.watch(kaziAppInfoServiceProvider),
  ref.watch(crashlyticsServiceProvider),
  ref.watch(kaziEffectiveLocaleProvider).languageCode,
);

@Riverpod(keepAlive: true)
SubscriptionService subscriptionService(Ref ref) =>
    RevenueCatSubscriptionService(Environment.instance.revenueCatApiKey);

@Riverpod(keepAlive: true)
Stream<Entitlement> entitlement(Ref ref) =>
    ref.watch(subscriptionServiceProvider).changes();

@Riverpod(keepAlive: true)
bool isPremium(Ref ref) =>
    ref.watch(entitlementProvider).asData?.value.isPremium ?? false;

@Riverpod(keepAlive: true)
InterstitialAdService interstitialAdService(Ref ref) =>
    AdMobInterstitialAdService(Environment.instance.adKeyServiceCreate);

@Riverpod(keepAlive: true)
Future<CreationAdCoordinator> creationAdCoordinator(Ref ref) async =>
    CreationAdCoordinator(
      adService: ref.watch(interstitialAdServiceProvider),
      storage: await ref.watch(localStorageProvider.future),
      remoteConfig: ref.watch(firebaseRemoteConfigProvider),
      isPremium: () => ref.read(isPremiumProvider),
      analytics: ref.watch(analyticsServiceProvider),
    );

@Riverpod(keepAlive: true)
BannerAdPolicy bannerAdPolicy(Ref ref) => BannerAdPolicy(
  isPremium: ref.watch(isPremiumProvider),
  remoteConfig: ref.watch(firebaseRemoteConfigProvider),
);

@Riverpod()
FreemiumGuard freemiumGuard(Ref ref) => FreemiumGuard(
  subscriptionService: ref.watch(subscriptionServiceProvider),
  servicesRepository: ref.watch(servicesRepositoryProvider),
  clientsRepository: ref.watch(clientsRepositoryProvider),
  timeService: ref.watch(timeServiceProvider),
  isPaymentsEnabled: ref.watch(isPaymentsEnabledProvider),
);
