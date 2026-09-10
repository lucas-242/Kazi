import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';

class BannerAdPolicy {
  BannerAdPolicy({
    required bool isPremium,
    required FirebaseRemoteConfig remoteConfig,
  }) : _isPremium = isPremium,
       frequency = _resolveFrequency(remoteConfig);

  static const int _defaultFrequency = 3;

  final bool _isPremium;

  /// Number of list items between two banners shown to free users.
  final int frequency;

  /// Whether a banner follows the item at [position] of a list of [total]
  /// items: after every [frequency]th item, and after the last one of a list
  /// shorter than that. Premium users never see one.
  bool shouldShowAfter(int position, {required int total}) {
    if (_isPremium || total <= 0) return false;

    final closesAGroup = (position + 1) % frequency == 0;
    final closesAShortList = total < frequency && position == total - 1;
    return closesAGroup || closesAShortList;
  }

  static int _resolveFrequency(FirebaseRemoteConfig remoteConfig) {
    final remote = remoteConfig.getInt(RemoteConfigKeys.bannerAdFrequency);
    return remote > 0 ? remote : _defaultFrequency;
  }
}
