import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_segment.dart';
import 'package:kazi/features/services/domain/repositories/services_repository.dart';
import 'package:kazi/features/settings/domain/repositories/user_settings_repository.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

part 'onboarding_controller.g.dart';

/// Decides which onboarding treatment the signed-in account gets.
///
/// Resolved lazily rather than in `bootstrap.dart`, and that placement is
/// deliberate: `KaziAppStartup` awaits this **after** confirming
/// authentication, so the uid is guaranteed to be there. Resolved during the
/// bootstrap it would race Firebase Auth restoring the session, and a null uid
/// would quietly classify a signed-in user as [OnboardingSegment.done] —
/// permanently, since nothing would ever ask again.
@Riverpod(keepAlive: true)
class OnboardingController extends _$OnboardingController {
  /// Above this many registered services, the account counts as one that is
  /// genuinely in use. One record is curiosity; two is someone coming back.
  static const int _activeUserServices = 2;

  UserSettingsRepository get _userSettings =>
      ref.read(userSettingsRepositoryProvider);

  ServicesRepository get _servicesRepository =>
      ref.read(servicesRepositoryProvider);

  AuthService get _authService => ref.read(authServiceProvider);

  @override
  Future<OnboardingSegment> build() async {
    final userId = _authService.user?.uid;
    if (userId == null) return OnboardingSegment.done;

    // Fail-open, like every other startup gate: a network blip must cost a
    // person the onboarding, never the app. The question is asked again on the
    // next launch, and nothing is lost meanwhile.
    try {
      final settings = await _userSettings.get(userId);
      if (settings.hasResolvedSetup) return OnboardingSegment.done;

      final serviceCount = await _servicesRepository.count(userId);
      if (serviceCount >= _activeUserServices) return OnboardingSegment.active;

      return serviceCount == 0
          ? OnboardingSegment.fresh
          : OnboardingSegment.stalled;
    } catch (exception) {
      Log.error(exception);
      return OnboardingSegment.done;
    }
  }

  /// Stamps the setup as finished and releases the route gate.
  Future<void> markCompleted() async {
    final userId = _authService.user?.uid;
    if (userId == null) return;

    await _userSettings.markSetupCompleted(userId);
    state = const AsyncData(OnboardingSegment.done);
  }

  /// Records that the user left through the close button. Same effect on the
  /// gate: an answer, even a negative one, is not asked twice.
  Future<void> markSkipped() async {
    final userId = _authService.user?.uid;
    if (userId == null) return;

    await _userSettings.markSetupSkipped(userId);
    state = const AsyncData(OnboardingSegment.done);
  }

  /// Debug only: clears the stamps and sends the account through the setup
  /// right away. The segment is forced rather than recomputed, because an
  /// account with services would resolve to [OnboardingSegment.active] and
  /// never see the setup again.
  Future<void> replayForDebug() async {
    final userId = _authService.user?.uid;
    if (userId == null) return;

    await _userSettings.resetOnboardingForDebug(userId);
    state = const AsyncData(OnboardingSegment.stalled);
  }
}
