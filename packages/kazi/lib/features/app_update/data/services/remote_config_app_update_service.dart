import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/services/domain/crashlytics_service.dart';
import 'package:kazi/core/utils/version_comparator.dart';
import 'package:kazi/features/app_update/domain/models/app_update_info.dart';
import 'package:kazi/features/app_update/domain/models/whats_new_entry.dart';
import 'package:kazi/features/app_update/domain/services/app_update_service.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

final class RemoteConfigAppUpdateService implements AppUpdateService {
  RemoteConfigAppUpdateService(
    this._remoteConfig,
    this._appInfoService,
    this._crashlyticsService,
    this._languageCode,
  );

  final FirebaseRemoteConfig _remoteConfig;
  final KaziAppInfoService _appInfoService;
  final CrashlyticsService _crashlyticsService;

  /// The device's resolved language, for picking the release announcement
  /// published in [RemoteConfigKeys.whatsNewContent].
  final String _languageCode;

  @override
  Future<AppUpdateInfo> checkForUpdate() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: kDebugMode
              ? Duration.zero
              : const Duration(hours: 1),
        ),
      );
      await _remoteConfig.setDefaults(RemoteConfigKeys.defaults);
      await _remoteConfig.fetchAndActivate();

      final currentVersion = await _appInfoService.getVersion();
      final minRequired = _remoteConfig.getString(
        RemoteConfigKeys.minRequiredVersion,
      );
      final latest = _remoteConfig.getString(RemoteConfigKeys.latestVersion);

      return AppUpdateInfo(
        status: _resolveStatus(
          current: currentVersion,
          minRequired: minRequired,
          latest: latest,
        ),
        latestVersion: latest,
        storeUrl: _storeUrl(),
        currentVersion: currentVersion,
        whatsNew: _parseWhatsNew(currentVersion: currentVersion),
      );
    } catch (exception, stackTrace) {
      // Fail-open: never lock the user out because of a fetch/parse failure.
      _crashlyticsService.log(exception, stackTrace);
      return const AppUpdateInfo.upToDate();
    }
  }

  AppUpdateStatus _resolveStatus({
    required String current,
    required String minRequired,
    required String latest,
  }) {
    if (VersionComparator.compareVersions(current, minRequired) < 0) {
      return AppUpdateStatus.mandatory;
    }
    if (VersionComparator.compareVersions(current, latest) < 0) {
      return AppUpdateStatus.optional;
    }
    return AppUpdateStatus.upToDate;
  }

  String _storeUrl() =>
      Platform.isIOS ? Environment.iosStoreUrl : Environment.androidStoreUrl;

  List<WhatsNewEntry> _parseWhatsNew({required String currentVersion}) {
    try {
      final raw = _remoteConfig.getString(RemoteConfigKeys.whatsNewContent);
      final map = jsonDecode(raw) as Map<String, dynamic>;
      if (map['version'] != currentVersion) {
        return const [];
      }

      final itemsByLocale = map['items'] as Map<String, dynamic>? ?? const {};
      final items = itemsByLocale[_languageCode] ?? itemsByLocale['en'];
      if (items is! List) {
        return const [];
      }

      return items
          .whereType<Map<String, dynamic>>()
          .map(WhatsNewEntry.fromMap)
          .take(3)
          .toList();
    } catch (exception, stackTrace) {
      _crashlyticsService.log(exception, stackTrace);
      return const [];
    }
  }
}
