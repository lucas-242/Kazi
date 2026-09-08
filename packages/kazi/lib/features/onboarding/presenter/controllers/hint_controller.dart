import 'dart:async';

import 'package:kazi/core/services/domain/analytics_event.dart';
import 'package:kazi/core/services/domain/analytics_service.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

part 'hint_controller.g.dart';

/// Decides whether a contextual hint may appear, and remembers that it did.
///
/// Three rules, all from experience with hints that outstay their welcome:
/// they wait for the opening's interruptions to be over, **only one is up at a
/// time**, and "Got it" means never again.
@Riverpod(keepAlive: true)
class HintController extends _$HintController {
  /// Held from just before a bubble goes up until it comes down — not for the
  /// rest of the session. Each screen the user reaches can still teach its own
  /// thing; what the slot prevents is two bubbles at once.
  bool _isSlotTaken = false;

  final _startup = Completer<void>();

  AnalyticsService get _analytics => ref.read(analyticsServiceProvider);

  @override
  void build() {}

  /// Completes once the opening's interruptions are done — the update dialog,
  /// the release note and the consent sheet. A bubble pointing at a widget
  /// behind a modal points at nothing, so anchors await this before asking
  /// [shouldShow].
  Future<void> get startupSettled => _startup.future;

  /// Releases the hints held back by [startupSettled]. Called once the shell
  /// has finished its first-frame chain.
  void markStartupSettled() {
    if (!_startup.isCompleted) _startup.complete();
  }

  /// Whether [hint] should be shown right now.
  Future<bool> shouldShow(OnboardingHint hint) async {
    if (_isSlotTaken) return false;
    if (KaziCoachMark.isShowing) return false;

    try {
      final storage = await ref.read(localStorageProvider.future);
      return !(await storage.read<bool>(hint.storageKey) ?? false);
    } catch (exception) {
      // A hint that cannot check itself simply does not appear. Showing it on
      // every launch would be worse than never showing it.
      Log.error(exception);
      return false;
    }
  }

  /// Claims the single hint slot. Call immediately before showing, so two
  /// anchors racing on the same frame cannot both win.
  void claimSlot() => _isSlotTaken = true;

  /// Frees the slot, once the bubble is down for any reason.
  ///
  /// The anchor that gave it up does not try again until it is mounted or
  /// revealed afresh, so the next hint belongs to the next screen the user
  /// reaches rather than to whatever else is on this one.
  void releaseSlot() => _isSlotTaken = false;

  Future<void> markSeen(OnboardingHint hint) async {
    releaseSlot();
    unawaited(
      _analytics.log(
        AnalyticsEvent.hintDismissed,
        parameters: {'hint': hint.name},
      ),
    );

    try {
      final storage = await ref.read(localStorageProvider.future);
      await storage.write(hint.storageKey, true);
    } catch (exception) {
      Log.error(exception);
    }
  }
}
