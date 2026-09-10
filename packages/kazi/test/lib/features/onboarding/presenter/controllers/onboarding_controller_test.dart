import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_segment.dart';
import 'package:kazi/features/onboarding/presenter/controllers/onboarding_controller.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/settings/domain/models/user_settings.dart';
import 'package:kazi/features/settings/domain/repositories/user_settings_repository.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart' hide CatalogItemRepository;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../../utils/test_helper.dart';
import 'onboarding_controller_test.mocks.dart';

@GenerateMocks([UserSettingsRepository, ServicesRepository, AuthService])
void main() {
  late MockUserSettingsRepository userSettings;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late ProviderContainer container;

  TestHelper.loadAppLocalizations();

  Future<OnboardingSegment> segment() =>
      container.read(onboardingControllerProvider.future);

  void build() {
    container = ProviderContainer(
      overrides: [
        userSettingsRepositoryProvider.overrideWithValue(userSettings),
        servicesRepositoryProvider.overrideWithValue(servicesRepository),
        authServiceProvider.overrideWithValue(authService),
      ],
    );
    addTearDown(container.dispose);
  }

  setUp(() {
    userSettings = MockUserSettingsRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);
    when(userSettings.get(any)).thenAnswer((_) async => const UserSettings());
    when(servicesRepository.count(any)).thenAnswer((_) async => 0);
    when(userSettings.markSetupCompleted(any)).thenAnswer((_) async {});
    when(userSettings.markSetupSkipped(any)).thenAnswer((_) async {});
  });

  group('segmentation', () {
    test('Should treat an account with nothing registered as fresh', () async {
      build();
      expect(await segment(), OnboardingSegment.fresh);
    });

    test('Should treat an account with a single service as stalled', () async {
      // Signed up, registered once, stopped. The people this whole delivery
      // is aimed at, and they get the same setup as a brand-new account.
      when(servicesRepository.count(any)).thenAnswer((_) async => 1);
      build();
      expect(await segment(), OnboardingSegment.stalled);
    });

    test('Should treat two or more services as an active user', () async {
      when(servicesRepository.count(any)).thenAnswer((_) async => 2);
      build();

      final result = await segment();
      expect(result, OnboardingSegment.active);
      expect(result.requiresSetup, isFalse);
    });

    test('Should not ask again once the setup was completed', () async {
      when(
        userSettings.get(any),
      ).thenAnswer((_) async => UserSettings(setupCompletedAt: DateTime(2026)));
      build();
      expect(await segment(), OnboardingSegment.done);
    });

    test('Should not ask again once the setup was skipped', () async {
      // Leaving is an answer too, and answers are not asked twice.
      when(
        userSettings.get(any),
      ).thenAnswer((_) async => UserSettings(setupSkippedAt: DateTime(2026)));
      build();
      expect(await segment(), OnboardingSegment.done);
    });
  });

  group('safety', () {
    test('Should fail open when the lookup throws', () async {
      // A network blip may cost someone the onboarding; it may never cost
      // them the app.
      when(userSettings.get(any)).thenThrow(Exception('offline'));
      build();
      expect(await segment(), OnboardingSegment.done);
    });

    test('Should resolve to done with no signed-in user', () async {
      when(authService.user).thenReturn(null);
      build();
      expect(await segment(), OnboardingSegment.done);
    });
  });

  group('stamps', () {
    test('Should release the gate on completion', () async {
      build();
      await segment();

      await container
          .read(onboardingControllerProvider.notifier)
          .markCompleted();

      verify(userSettings.markSetupCompleted(any)).called(1);
      expect(
        container.read(onboardingControllerProvider).value,
        OnboardingSegment.done,
      );
    });

    test('Should release the gate on skip', () async {
      build();
      await segment();

      await container.read(onboardingControllerProvider.notifier).markSkipped();

      verify(userSettings.markSetupSkipped(any)).called(1);
      expect(
        container.read(onboardingControllerProvider).value,
        OnboardingSegment.done,
      );
    });
  });

  group('debug replay', () {
    test('Should send even an active account back to the setup', () async {
      when(servicesRepository.count(any)).thenAnswer((_) async => 2);
      when(userSettings.resetOnboardingForDebug(any)).thenAnswer((_) async {});
      build();
      await segment();

      await container
          .read(onboardingControllerProvider.notifier)
          .replayForDebug();

      verify(userSettings.resetOnboardingForDebug(any)).called(1);
      expect(
        container.read(onboardingControllerProvider).value?.requiresSetup,
        isTrue,
      );
    });
  });
}
