import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/services/data/analytics/analytics_identity_controller.dart';
import 'package:kazi/core/services/data/crashlytics/crashlytics_identity.dart';
import 'package:kazi/features/app_update/app_update.dart';
import 'package:kazi/features/settings/presenter/controllers/privacy_controller.dart';
import 'package:kazi/features/settings/settings.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

part 'bootstrap.g.dart';

/// Everything the router needs before it can choose a screen, run while the
/// branded splash is on screen and awaited against its minimum duration.
///
/// Nothing here throws: every step is individually fail-open, because the only
/// outcome worse than a stale feature flag is a user stuck on the splash. The
/// order below is not arbitrary — see README.md.
@riverpod
Future<void> appBootstrap(Ref ref) async {
  // First, and not gated by consent: crash attribution is diagnostic, and a
  // crash in any step below should already carry a uid. Reading it starts it.
  ref.read(crashlyticsIdentityProvider);

  // Not needed before the first list that shows one, so it runs alongside the
  // config work instead of in front of it.
  final ads = _guard('MobileAds.initialize', _initializeAds, ref);

  // Before the update check, which reads its thresholds from Remote Config.
  await _guard(
    'FeatureFlagService.init',
    () => ref.read(featureFlagServiceProvider).init(),
    ref,
  );

  await _guard(
    'AppUpdateController.check',
    () => ref.read(appUpdateControllerProvider.notifier).check(),
    ref,
  );

  // Before the home renders: every total is meaningless without the currency.
  await _guard(
    'CurrencyMigrationController.check',
    () => ref.read(currencyMigrationControllerProvider.notifier).check(),
    ref,
  );

  await _guard('AnalyticsBootstrap', () => _startAnalytics(ref), ref);

  await ads;
}

/// Brings up the ads SDK with the test devices declared for this flavor.
///
/// The request configuration is applied *before* `initialize`: a device that
/// reaches Google as a real user while a developer is exercising creation flows
/// is what invalid-traffic strikes are made of. See
/// [services/data/ads/README.md](services/data/ads/README.md).
Future<void> _initializeAds() async {
  final testDeviceIds = Environment.instance.testDeviceIds;

  if (testDeviceIds.isNotEmpty) {
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: testDeviceIds),
    );
  }

  await MobileAds.instance.initialize();
}

/// Opens the telemetry tap, once the thing it depends on is known: what the
/// user consented to.
Future<void> _startAnalytics(Ref ref) async {
  final bootstrap = ref.read(analyticsBootstrapProvider);
  final privacy = await ref.read(privacyControllerProvider.future);

  await bootstrap.applyConsent(
    analyticsAllowed: privacy.isAnalyticsAllowed,
    replayAllowed: privacy.isReplayAllowed,
  );

  await bootstrap.applySampling(
    policy: ref.read(sessionReplayPolicyProvider),
    replayAllowed: privacy.isReplayAllowed,
    accountAgeDays: _accountAgeDays(ref),
  );

  if (privacy.isAnalyticsAllowed) {
    ref
        .read(tapHeatmapRecorderProvider)
        .applySampling(ref.read(tapHeatmapPolicyProvider));
  }

  // Reading them is what starts them: keepAlive listeners with no other
  // subscriber. `analyticsRouteReporterProvider` is deliberately absent — it
  // would close a dependency cycle back onto this bootstrap. See README.md.
  ref.read(analyticsIdentityControllerProvider);
  ref.read(analyticsConsentSyncProvider);
}

/// Carries a change made in Menu › Privacy down to the SDKs. The composite
/// already gates every event this app sends, but not what the SDKs send on
/// their own — `session_start`, `$app_opened`, a replay already in progress.
@Riverpod(keepAlive: true)
void analyticsConsentSync(Ref ref) {
  ref.listen(privacyControllerProvider, (previous, next) {
    final settings = next.asData?.value;
    if (settings == null) return;

    final allowed = settings.isAnalyticsAllowed;

    unawaited(
      ref
          .read(analyticsBootstrapProvider)
          .applyConsent(
            analyticsAllowed: allowed,
            replayAllowed: settings.isReplayAllowed,
          )
          .then((_) {
            // Consent granted after the launch decision was made, so the
            // session gets its roll now rather than at the next launch.
            if (!allowed || !settings.isReplayAllowed) return;
            if (previous?.asData?.value.isReplayAllowed ?? false) return;
            unawaited(
              ref
                  .read(analyticsBootstrapProvider)
                  .applySampling(
                    policy: ref.read(sessionReplayPolicyProvider),
                    replayAllowed: true,
                    accountAgeDays: _accountAgeDays(ref),
                  ),
            );
          }),
    );
  });
}

int? _accountAgeDays(Ref ref) {
  final createdAt = ref.read(authServiceProvider).user?.createdAt;
  if (createdAt == null) return null;
  return ref.read(timeServiceProvider).now.difference(createdAt).inDays;
}

/// Runs [step], reporting a failure to Crashlytics instead of propagating it.
Future<void> _guard(String name, Future<void> Function() step, Ref ref) async {
  try {
    await step();
  } catch (exception, stackTrace) {
    Log.error('Bootstrap step "$name" failed: $exception');
    ref.read(crashlyticsServiceProvider).log(exception, stackTrace);
  }
}
