import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';
import 'package:kazi/core/services/data/ads/banner_ad_policy.dart';

class _FakeRemoteConfig implements FirebaseRemoteConfig {
  _FakeRemoteConfig(this._frequency);

  final int _frequency;

  @override
  int getInt(String key) =>
      key == RemoteConfigKeys.bannerAdFrequency ? _frequency : 0;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  BannerAdPolicy build({int frequency = 3, bool isPremium = false}) =>
      BannerAdPolicy(
        isPremium: isPremium,
        remoteConfig: _FakeRemoteConfig(frequency),
      );

  List<int> positionsFollowedByBanner(BannerAdPolicy policy, int total) => [
    for (var position = 0; position < total; position++)
      if (policy.shouldShowAfter(position, total: total)) position,
  ];

  test('follows every Nth item', () {
    final policy = build();

    expect(policy.frequency, 3);
    expect(positionsFollowedByBanner(policy, 3), [2]);
    expect(positionsFollowedByBanner(policy, 7), [2, 5]);
    expect(positionsFollowedByBanner(policy, 9), [2, 5, 8]);
  });

  test('follows the last item of a list shorter than N', () {
    final policy = build();

    expect(positionsFollowedByBanner(policy, 1), [0]);
    expect(positionsFollowedByBanner(policy, 2), [1]);
  });

  test('an empty list carries no banner', () {
    expect(build().shouldShowAfter(0, total: 0), isFalse);
  });

  test('premium users never see a banner', () {
    final policy = build(isPremium: true);

    expect(positionsFollowedByBanner(policy, 1), isEmpty);
    expect(positionsFollowedByBanner(policy, 9), isEmpty);
  });

  test('falls back to the default frequency when remote config is unset', () {
    final policy = build(frequency: 0);

    expect(policy.frequency, 3);
    expect(positionsFollowedByBanner(policy, 6), [2, 5]);
  });

  test('honors a remotely configured frequency', () {
    final policy = build(frequency: 5);

    expect(positionsFollowedByBanner(policy, 4), [3]);
    expect(positionsFollowedByBanner(policy, 10), [4, 9]);
  });
}
