import 'package:kazi/core/services/domain/feature_flag.dart';

abstract class RemoteConfigKeys {
  static const String minRequiredVersion = 'min_required_version';
  static const String latestVersion = 'latest_version';

  /// Number of creation actions between two interstitial ads shown to free
  /// users. Tunable remotely; falls back to a code default when unset/invalid.
  static const String interstitialAdFrequency = 'interstitial_ad_frequency';

  /// Number of list items between two banner ads shown to free users. Tunable
  /// remotely; falls back to a code default when unset/invalid.
  static const String bannerAdFrequency = 'banner_ad_frequency';

  /// Master switch for session replay — the expensive, most privacy-sensitive
  /// half of the telemetry, and the one to reach for first. Takes effect on the
  /// next app start.
  static const String replayEnabled = 'replay_enabled';

  /// Percentage (0–100) of sessions recorded for accounts younger than
  /// [replayNewUserDays]. Defaults to everything: the first week is where
  /// abandonment happens, and a sample of it answers nothing.
  static const String replaySampleNewUsers = 'replay_sample_new_users';

  /// Percentage (0–100) of sessions recorded for everyone else. Enough to spot
  /// a pattern, small enough not to dominate the replay quota.
  static const String replaySampleReturning = 'replay_sample_returning';

  /// Whether detected friction promotes a session to being recorded mid-flight,
  /// regardless of the sampling above.
  static const String replayOnFriction = 'replay_on_friction';

  /// Account age, in days, below which a user still counts as new for the
  /// sampling split.
  static const String replayNewUserDays = 'replay_new_user_days';

  /// Master switch for tap capture. Unlike the replay switches, an unresolved
  /// key reads as **off**: this one has never been on in production, so a
  /// failed fetch must not be what turns it on for the first time.
  static const String heatmapEnabled = 'heatmap_enabled';

  /// Percentage (0–100) of sessions that capture taps. Rolled once per session,
  /// like the replay sampling.
  static const String heatmapSamplePercent = 'heatmap_sample_percent';

  /// Hard ceiling of tap events per session. Without it one person scrolling a
  /// long list is worth hundreds of events, and the shape of the first few
  /// hundred taps is all the map needs.
  static const String heatmapMaxEventsSession = 'heatmap_max_events_session';

  /// JSON: `{"version": "1.4.0", "items": {"languageCode": [{"title",
  /// "description"}, up to 3]}}`. `RemoteConfigAppUpdateService` only surfaces
  /// the items when `version` matches the version installed on the device —
  /// otherwise a console value left over from before this release shipped
  /// would describe a release nobody is running.
  static const String whatsNewContent = 'whats_new_content';

  /// Single defaults map for the whole app — Remote Config's `setDefaults`
  /// replaces the previous map wholesale, so every key must be declared here.
  /// Feature flags contribute their own keys straight from [FeatureFlag].
  static Map<String, dynamic> get defaults => {
    minRequiredVersion: '0.0.0',
    latestVersion: '0.0.0',
    interstitialAdFrequency: 3,
    bannerAdFrequency: 3,
    replayEnabled: true,
    replaySampleNewUsers: 100,
    replaySampleReturning: 20,
    replayOnFriction: true,
    replayNewUserDays: 7,
    heatmapEnabled: false,
    heatmapSamplePercent: 10,
    heatmapMaxEventsSession: 300,
    whatsNewContent: '{"version":"","items":{}}',
    for (final flag in FeatureFlag.values) flag.key: flag.defaultValue,
  };
}
