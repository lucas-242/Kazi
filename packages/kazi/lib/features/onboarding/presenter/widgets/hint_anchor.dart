import 'package:flutter/material.dart';
import 'package:kazi/features/onboarding/domain/models/onboarding_hint.dart';
import 'package:kazi/features/onboarding/presenter/controllers/hint_controller.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Wraps the widget a hint points at, and shows the hint once the widget is
/// actually on screen.
///
/// Everything that makes a hint safe lives here rather than at each of the four
/// call sites: it waits for layout and for the opening's interruptions, asks
/// whether the hint is still owed, claims the one-per-session slot, and records
/// the dismissal.
///
/// The anchor can stop deserving its hint at any point — the user changes tab,
/// [enabled] flips, a page is pushed over it. Every one of those retracts the
/// hint and gives the slot back, so it is offered again the next time the
/// anchor is genuinely in front of the user, rather than being burned on a
/// bubble nobody could act on.
class HintAnchor extends ConsumerStatefulWidget {
  const HintAnchor({
    super.key,
    required this.hint,
    required this.child,
    this.enabled = true,
    this.radius,
  });

  final OnboardingHint hint;
  final Widget child;

  /// The anchor's own corner radius, which the ring repeats. Leave null for
  /// anything round — a circle, a pill, an icon button — and pass the radius
  /// for a squarer anchor, or it gets ringed as a pill it is not.
  final double? radius;

  /// Extra condition on top of "not seen yet" — the filters hint waits for a
  /// history worth filtering, for instance.
  final bool enabled;

  @override
  ConsumerState<HintAnchor> createState() => _HintAnchorState();
}

class _HintAnchorState extends ConsumerState<HintAnchor> {
  final _anchorKey = GlobalKey();
  bool _attempting = false;
  bool _showing = false;

  /// False while the anchor sits on an inactive shell branch: go_router keeps
  /// those laid out and measurable, so nothing else here would notice that the
  /// user is looking at another tab.
  bool _isOnScreen = true;

  /// Held rather than read on demand: `dispose` retracts the bubble, and `ref`
  /// is no longer readable by then.
  late final HintController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(hintControllerProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isOnScreen = TickerMode.valuesOf(context).enabled;
    if (isOnScreen == _isOnScreen) return;

    _isOnScreen = isOnScreen;
    if (isOnScreen) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShow());
    } else {
      _retract();
    }
  }

  @override
  void didUpdateWidget(HintAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled == oldWidget.enabled) return;

    // `enabled` can flip either way after the first frame — the services list
    // only earns its hint once enough records exist, and the shell FAB stops
    // deserving the one it is showing as soon as the user leaves the home tab.
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShow());
    } else {
      _retract();
    }
  }

  @override
  void dispose() {
    _retract();
    super.dispose();
  }

  bool get _canShow =>
      mounted &&
      widget.enabled &&
      _isOnScreen &&
      (ModalRoute.of(context)?.isCurrent ?? true);

  Future<void> _maybeShow() async {
    if (_attempting || _showing || !_canShow) return;
    _attempting = true;

    try {
      await _controller.startupSettled;
      if (!mounted || !_canShow) return;

      if (!await _controller.shouldShow(widget.hint)) return;
      if (!mounted || !_canShow) return;

      // Claimed before showing, so a second anchor mounting on the same frame
      // finds the slot taken rather than stacking a second bubble.
      _controller.claimSlot();
      _showing = true;

      KaziCoachMark.show(
        context,
        owner: this,
        anchorKey: _anchorKey,
        title: widget.hint.title,
        message: widget.hint.message,
        anchorRadius: widget.radius,
        onDismiss: () {
          _showing = false;
          _controller.markSeen(widget.hint);
        },
        onLost: _onRetracted,
      );
    } finally {
      _attempting = false;
    }
  }

  /// Takes the bubble down without recording it as seen: the user never got to
  /// act on it, so the hint is still owed.
  void _retract() {
    if (!_showing) return;
    KaziCoachMark.hide(owner: this);
    _onRetracted();
  }

  void _onRetracted() {
    _showing = false;
    _controller.releaseSlot();
  }

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: _anchorKey, child: widget.child);
}
