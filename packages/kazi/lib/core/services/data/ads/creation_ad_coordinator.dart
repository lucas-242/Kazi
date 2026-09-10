import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';
import 'package:kazi/core/constants/storage_keys.dart';
import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/core/services/domain/analytics_service.dart';
import 'package:kazi/core/services/domain/interstitial_ad_service.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Single source of truth for the post-creation interstitial ad.
///
/// Every "creation action" — saving a client, a catalog item or a service —
/// increments a persisted counter. The interstitial is only shown once the
/// counter reaches the configured frequency (Firebase Remote Config, falling
/// back to [_defaultFrequency]) and only for free users. Quick-add flows inside
/// the service form pass `canShowNow: false` so the ad never interrupts the
/// form; their actions still count toward the next eligible show.
class CreationAdCoordinator {
  CreationAdCoordinator({
    required InterstitialAdService adService,
    required KaziLocalStorageService storage,
    required FirebaseRemoteConfig remoteConfig,
    required bool Function() isPremium,
    required AnalyticsService analytics,
  }) : _adService = adService,
       _storage = storage,
       _remoteConfig = remoteConfig,
       _isPremium = isPremium,
       _analytics = analytics;

  static const int _defaultFrequency = 3;

  final InterstitialAdService _adService;
  final KaziLocalStorageService _storage;
  final FirebaseRemoteConfig _remoteConfig;
  final bool Function() _isPremium;
  final AnalyticsService _analytics;

  /// Starts loading the interstitial for a free user ahead of the creation that
  /// may show it. The first load takes seconds, and a save that reaches the
  /// frequency before it lands shows nothing.
  void prepare() {
    if (_isPremium()) return;
    _adService.preload();
  }

  /// Registers a creation action and shows the interstitial once the persisted
  /// action counter reaches the configured frequency. A service form save is
  /// one action whatever its quantity. Pass [canShowNow] = false for actions
  /// that must never surface an ad inline (the service form's quick-add
  /// sheets); those still count toward the next eligible show.
  Future<void> onCreationAction({bool canShowNow = true}) async {
    try {
      if (_isPremium()) return;

      final nextCount = await _readCount() + 1;

      if (canShowNow && nextCount >= _frequency()) {
        final shown = await _adService.showIfAvailable();
        // Reported here rather than from the ad SDK's own callbacks, because
        // the question this answers is about the *app*: how much advertising a
        // free user is actually exposed to per session, so retention can be cut
        // by it. A failed load is the other half of that answer — the ad slot
        // fired and produced nothing.
        unawaited(
          _analytics.log(
            shown
                ? AnalyticsEvent.interstitialShown
                : AnalyticsEvent.interstitialLoadFailed,
          ),
        );
        // Only reset when an ad actually showed; otherwise keep the count so the
        // next eligible action retries instead of waiting a full cycle.
        await _writeCount(shown ? 0 : nextCount);
      } else {
        await _writeCount(nextCount);
        _adService.preload();
      }
    } catch (exception) {
      // Ad bookkeeping must never break an otherwise successful creation.
      Log.error('Failed to handle creation ad: $exception');
    }
  }

  int _frequency() {
    final remote = _remoteConfig.getInt(
      RemoteConfigKeys.interstitialAdFrequency,
    );
    return remote > 0 ? remote : _defaultFrequency;
  }

  Future<int> _readCount() async =>
      await _storage.read<int>(StorageKeys.interstitialActionCount) ?? 0;

  Future<void> _writeCount(int value) =>
      _storage.write<int>(StorageKeys.interstitialActionCount, value);
}
