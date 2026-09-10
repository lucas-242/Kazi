import 'package:equatable/equatable.dart';
import 'package:kazi/features/auth/domain/services/auth_service.dart';
import 'package:kazi/features/onboarding/presenter/controllers/onboarding_controller.dart';
import 'package:kazi/features/services/domain/models/catalog_item.dart';
import 'package:kazi/features/services/domain/repositories/catalog_item_repository.dart';
import 'package:kazi/features/settings/domain/models/billing_cycle.dart';
import 'package:kazi/features/settings/domain/repositories/user_settings_repository.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

part 'active_user_nudges_controller.g.dart';

class ActiveUserNudgesState extends Equatable {
  const ActiveUserNudgesState({
    this.askCycleConfirmation = false,
    this.itemsMissingCommission = const [],
  });

  /// Whether to ask the one question worth interrupting for.
  final bool askCycleConfirmation;

  /// Types whose commission was never configured. Their value counts toward
  /// the total generated but not toward what the user receives, which makes
  /// the home understate their earnings without saying so.
  final List<CatalogItem> itemsMissingCommission;

  bool get hasCommissionGaps => itemsMissingCommission.isNotEmpty;

  @override
  List<Object?> get props => [askCycleConfirmation, itemsMissingCommission];
}

/// What the app asks of people who are already using it — which is as close to
/// nothing as the change allows.
///
/// Someone active opens Kazi to record a job, not to configure it. Everything
/// here is a dismissible card on the home; there is no full screen, no modal,
/// and nothing that comes back on the next launch once answered.
@Riverpod(keepAlive: true)
class ActiveUserNudgesController extends _$ActiveUserNudgesController {
  UserSettingsRepository get _userSettings =>
      ref.read(userSettingsRepositoryProvider);

  CatalogItemRepository get _catalogItemRepository =>
      ref.read(catalogItemRepositoryProvider);

  AuthService get _authService => ref.read(authServiceProvider);

  /// Dismissals are per session, not persisted: both cards describe something
  /// still unresolved, and a card that never returns would quietly leave the
  /// user's totals wrong forever. Answering either one removes it for good.
  bool _cycleDismissed = false;
  bool _gapsDismissed = false;

  @override
  Future<ActiveUserNudgesState> build() async {
    final segment = await ref.watch(onboardingControllerProvider.future);
    if (!segment.isActiveUser) return const ActiveUserNudgesState();

    final userId = _authService.user?.uid;
    if (userId == null) return const ActiveUserNudgesState();

    try {
      final settings = await _userSettings.get(userId);
      final items = await _catalogItemRepository.get(userId);

      return ActiveUserNudgesState(
        // Asked only of people who never answered it. The stored cycle is
        // monthly either way, so the field's presence is the only thing that
        // separates a decision from a default.
        askCycleConfirmation:
            !_cycleDismissed && !settings.hasExplicitBillingCycle,
        itemsMissingCommission: _gapsDismissed
            ? const []
            : items
                  // Archived types take no new services, and the catalog the
                  // card opens does not list them: there is nothing to fix.
                  .where(
                    (item) =>
                        !item.isArchived &&
                        item.effectiveCommissionPercent == null,
                  )
                  .toList(),
      );
    } catch (exception) {
      Log.error(exception);
      return const ActiveUserNudgesState();
    }
  }

  /// Confirms the cycle the app is already using — a confirmation, not a form.
  Future<void> confirmCycle() async {
    final userId = _authService.user?.uid;
    if (userId == null) return;

    _cycleDismissed = true;
    try {
      // Writes the default explicitly so the answer is recorded rather than
      // inferred from its absence.
      await _userSettings.setBillingCycle(userId, BillingCycle.monthlyDefault);
    } catch (exception) {
      Log.error(exception);
    }
    ref.invalidateSelf();
  }

  void dismissCycle() {
    _cycleDismissed = true;
    ref.invalidateSelf();
  }

  void dismissGaps() {
    _gapsDismissed = true;
    ref.invalidateSelf();
  }
}
