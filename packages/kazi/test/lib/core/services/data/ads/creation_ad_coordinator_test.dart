import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';
import 'package:kazi/core/constants/storage_keys.dart';
import 'package:kazi/core/services/data/ads/creation_ad_coordinator.dart';
import 'package:kazi/core/services/domain/interstitial_ad_service.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

import '../../../../../utils/fakes/fake_analytics_service.dart';

class _FakeInterstitialAdService implements InterstitialAdService {
  _FakeInterstitialAdService({this.adReady = true});

  bool adReady;
  int showCalls = 0;
  int preloadCalls = 0;

  @override
  void preload() => preloadCalls++;

  @override
  Future<bool> showIfAvailable() async {
    showCalls++;
    return adReady;
  }
}

class _InMemoryStorage implements KaziLocalStorageService {
  final Map<String, Object?> _store = {};

  @override
  Future<void> write<T>(String key, T value) async => _store[key] = value;

  @override
  Future<T?> read<T>(String key) async => _store[key] as T?;

  @override
  Future<bool> containsKey(String key) async => _store.containsKey(key);

  @override
  Future<void> remove(String key) async => _store.remove(key);

  @override
  Future<void> clear() async => _store.clear();
}

class _FakeRemoteConfig implements FirebaseRemoteConfig {
  _FakeRemoteConfig(this._frequency);

  final int _frequency;

  @override
  int getInt(String key) =>
      key == RemoteConfigKeys.interstitialAdFrequency ? _frequency : 0;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeInterstitialAdService adService;
  late _InMemoryStorage storage;
  late FakeAnalyticsService analytics;

  CreationAdCoordinator build({
    int frequency = 3,
    bool isPremium = false,
    bool adReady = true,
  }) {
    adService = _FakeInterstitialAdService(adReady: adReady);
    storage = _InMemoryStorage();
    analytics = FakeAnalyticsService();
    return CreationAdCoordinator(
      adService: adService,
      storage: storage,
      remoteConfig: _FakeRemoteConfig(frequency),
      isPremium: () => isPremium,
      analytics: analytics,
    );
  }

  Future<int?> storedCount() =>
      storage.read<int>(StorageKeys.interstitialActionCount);

  test(
    'shows the ad and resets the counter once the frequency is reached',
    () async {
      final coordinator = build();

      await coordinator.onCreationAction();
      await coordinator.onCreationAction();
      expect(adService.showCalls, 0, reason: 'below the threshold');
      expect(await storedCount(), 2);

      await coordinator.onCreationAction();
      expect(adService.showCalls, 1);
      expect(await storedCount(), 0, reason: 'counter resets after showing');
    },
  );

  test(
    'starts loading below the threshold, for the action that reaches it',
    () async {
      final coordinator = build();

      await coordinator.onCreationAction();

      expect(adService.preloadCalls, 1);
    },
  );

  test('prepares the ad for free users only', () {
    build().prepare();
    expect(adService.preloadCalls, 1);

    build(isPremium: true).prepare();
    expect(adService.preloadCalls, 0);
  });

  test('premium users never accrue count nor see the ad', () async {
    final coordinator = build(isPremium: true);

    await coordinator.onCreationAction();
    await coordinator.onCreationAction();
    await coordinator.onCreationAction();

    expect(adService.showCalls, 0);
    expect(await storedCount(), isNull);
  });

  test('quick-add actions count but never show the ad inline', () async {
    final coordinator = build();

    // Two inline quick-adds reach the threshold but must not surface an ad.
    await coordinator.onCreationAction(canShowNow: false);
    await coordinator.onCreationAction(canShowNow: false);
    await coordinator.onCreationAction(canShowNow: false);
    expect(adService.showCalls, 0);
    expect(await storedCount(), 3);

    // The next top-level save is eligible and shows immediately.
    await coordinator.onCreationAction();
    expect(adService.showCalls, 1);
    expect(await storedCount(), 0);
  });

  test('keeps the count when no ad was ready, retrying next action', () async {
    final coordinator = build(frequency: 2, adReady: false);

    await coordinator.onCreationAction();
    await coordinator.onCreationAction();
    expect(adService.showCalls, 1, reason: 'tried to show at the threshold');
    expect(await storedCount(), 2, reason: 'no reset since nothing showed');

    adService.adReady = true;
    await coordinator.onCreationAction();
    expect(adService.showCalls, 2);
    expect(await storedCount(), 0);
  });

  test(
    'falls back to the default frequency when remote config is unset',
    () async {
      // frequency 0 => getInt returns 0 => coordinator uses its default of 3.
      final coordinator = build(frequency: 0);

      await coordinator.onCreationAction();
      await coordinator.onCreationAction();
      expect(adService.showCalls, 0);

      await coordinator.onCreationAction();
      expect(adService.showCalls, 1);
    },
  );
}
