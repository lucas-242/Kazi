import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/constants/remote_config_keys.dart';
import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/services/domain/crashlytics_service.dart';
import 'package:kazi/features/app_update/data/services/remote_config_app_update_service.dart';
import 'package:kazi/features/app_update/domain/models/app_update_info.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_config_app_update_service_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig, KaziAppInfoService, CrashlyticsService])
void main() {
  late MockFirebaseRemoteConfig remoteConfig;
  late MockKaziAppInfoService appInfoService;
  late MockCrashlyticsService crashlyticsService;
  late RemoteConfigAppUpdateService service;

  const currentVersion = '1.2.0';

  void stubVersions({required String minRequired, required String latest}) {
    when(
      remoteConfig.getString(RemoteConfigKeys.minRequiredVersion),
    ).thenReturn(minRequired);
    when(
      remoteConfig.getString(RemoteConfigKeys.latestVersion),
    ).thenReturn(latest);
  }

  setUp(() {
    remoteConfig = MockFirebaseRemoteConfig();
    appInfoService = MockKaziAppInfoService();
    crashlyticsService = MockCrashlyticsService();
    service = RemoteConfigAppUpdateService(
      remoteConfig,
      appInfoService,
      crashlyticsService,
      'en',
    );

    when(
      remoteConfig.getString(RemoteConfigKeys.whatsNewContent),
    ).thenReturn('{"version":"","items":{}}');

    when(
      remoteConfig.setConfigSettings(any),
    ).thenAnswer((_) => Future<void>.value());
    when(remoteConfig.setDefaults(any)).thenAnswer((_) => Future<void>.value());
    when(remoteConfig.fetchAndActivate()).thenAnswer((_) async => true);
    when(appInfoService.getVersion()).thenAnswer((_) async => currentVersion);
  });

  test('returns upToDate when current version meets the latest', () async {
    stubVersions(minRequired: '1.0.0', latest: '1.2.0');

    final info = await service.checkForUpdate();

    expect(info.status, AppUpdateStatus.upToDate);
  });

  test('returns optional when a newer version is available', () async {
    stubVersions(minRequired: '1.0.0', latest: '1.4.0');

    final info = await service.checkForUpdate();

    expect(info.status, AppUpdateStatus.optional);
    expect(info.latestVersion, '1.4.0');
  });

  test('returns mandatory when below the minimum required', () async {
    stubVersions(minRequired: '1.3.0', latest: '1.4.0');

    final info = await service.checkForUpdate();

    expect(info.status, AppUpdateStatus.mandatory);
  });

  test('carries the store url the mandatory screen sends people to', () async {
    stubVersions(minRequired: '1.3.0', latest: '1.4.0');

    final info = await service.checkForUpdate();

    expect(
      info.storeUrl,
      anyOf(Environment.androidStoreUrl, Environment.iosStoreUrl),
      reason: 'the url is a constant in the app, not a Remote Config key. '
          'Reading it as one answers with an empty string, and the screen '
          'nobody can leave gets a button that goes nowhere',
    );
  });

  test('fail-open: returns upToDate and logs when fetch throws', () async {
    when(remoteConfig.fetchAndActivate()).thenThrow(Exception('offline'));

    final info = await service.checkForUpdate();

    expect(info.status, AppUpdateStatus.upToDate);
    verify(crashlyticsService.log(any, any)).called(1);
  });

  group('whats new', () {
    /// The payload as it is meant to be pasted into the console, for the
    /// version this device is running.
    const published =
        '{'
        '"version":"$currentVersion",'
        '"items":{'
        '"pt":['
        '{"title":"Ciclo de pagamento","description":"O total do topo agora segue o dia em que voce recebe."},'
        '{"title":"Resumo dentro de Servicos","description":"A mesma lista, vista por tipo e por cliente."},'
        '{"title":"Catalogo por profissao","description":"Quem comeca agora ja entra com os servicos cadastrados."}'
        '],'
        '"en":[{"title":"Pay cycle","description":"The total now follows the day you get paid."}]'
        '}}';

    void stubWhatsNew(String raw) {
      when(
        remoteConfig.getString(RemoteConfigKeys.whatsNewContent),
      ).thenReturn(raw);
    }

    setUp(() => stubVersions(minRequired: '1.0.0', latest: '1.2.0'));

    test('reads the entries published for the installed version', () async {
      stubWhatsNew(published);

      final info = await service.checkForUpdate();

      expect(info.currentVersion, currentVersion);
      expect(info.whatsNew, hasLength(1));
      expect(info.whatsNew.first.title, 'Pay cycle');
    });

    test('falls back to English when the language has no translation', () async {
      service = RemoteConfigAppUpdateService(
        remoteConfig,
        appInfoService,
        crashlyticsService,
        'de',
      );
      stubWhatsNew(published);

      final info = await service.checkForUpdate();

      expect(info.whatsNew.first.title, 'Pay cycle');
    });

    test('takes the published language over English', () async {
      service = RemoteConfigAppUpdateService(
        remoteConfig,
        appInfoService,
        crashlyticsService,
        'pt',
      );
      stubWhatsNew(published);

      final info = await service.checkForUpdate();

      expect(info.whatsNew, hasLength(3));
      expect(info.whatsNew.first.title, 'Ciclo de pagamento');
    });

    test('announces nothing when the copy is for another version', () async {
      stubWhatsNew('{"version":"9.9.9","items":{"en":[{"title":"x"}]}}');

      final info = await service.checkForUpdate();

      expect(info.whatsNew, isEmpty);
    });

    test('announces nothing when the console value is malformed', () async {
      stubWhatsNew('not json');

      final info = await service.checkForUpdate();

      expect(info.whatsNew, isEmpty);
      expect(info.status, AppUpdateStatus.upToDate);
    });
  });
}
