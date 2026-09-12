import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';

/// Decides whether this session contributes taps to the heatmap, and how many.
///
/// Same shape as `SessionReplayPolicy` — pure, every number from Remote Config,
/// so the volume can be cut to zero without a release. See README.md for why
/// the kill switch resolves the other way round from the replay one.
class TapHeatmapPolicy {
  TapHeatmapPolicy({required FirebaseRemoteConfig remoteConfig})
    : isEnabled = _isEnabled(remoteConfig),
      samplePercent = _percent(remoteConfig),
      maxEventsPerSession = _maxEvents(remoteConfig);

  /// Used by tests and by any path where Remote Config has not resolved.
  const TapHeatmapPolicy.raw({
    required this.isEnabled,
    required this.samplePercent,
    required this.maxEventsPerSession,
  });

  static const int defaultSamplePercent = 10;
  static const int defaultMaxEventsPerSession = 300;

  final bool isEnabled;
  final int samplePercent;
  final int maxEventsPerSession;

  /// [roll] is drawn once per session by the caller, in `[0, 1)`, which keeps
  /// this pure and the sampling testable at its edges.
  bool shouldCaptureAtStart({required double roll}) {
    if (!isEnabled) return false;
    if (samplePercent <= 0) return false;
    if (samplePercent >= 100) return true;
    return roll * 100 < samplePercent;
  }

  /// Off when the key is unknown, which is the opposite of the replay switches:
  /// those are operational switches for something already running, so an
  /// unresolved key means "carry on". This one has never been on in production,
  /// and a failed fetch must not be what turns it on for the first time.
  static bool _isEnabled(FirebaseRemoteConfig remoteConfig) {
    final value = remoteConfig.getValue(RemoteConfigKeys.heatmapEnabled);
    if (value.source == ValueSource.valueStatic) return false;
    return value.asBool();
  }

  /// Falls back when the key is unknown or was set outside 0–100.
  static int _percent(FirebaseRemoteConfig remoteConfig) {
    final value = remoteConfig.getValue(RemoteConfigKeys.heatmapSamplePercent);
    if (value.source == ValueSource.valueStatic) return defaultSamplePercent;
    final remote = value.asInt();
    return remote >= 0 && remote <= 100 ? remote : defaultSamplePercent;
  }

  static int _maxEvents(FirebaseRemoteConfig remoteConfig) {
    final remote = remoteConfig.getInt(
      RemoteConfigKeys.heatmapMaxEventsSession,
    );
    return remote > 0 ? remote : defaultMaxEventsPerSession;
  }
}
