import 'package:flutter/material.dart';
import 'package:kazi/core/routes/current_screen.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Feeds the rage-tap half of `FrictionDetector` from one control.
///
/// Listens to the pointer, not to `onTap`, and that is the whole design: a rage
/// tap is by definition a tap the control did *not* act on — the form refused to
/// validate, the button was disabled, a save was already in flight. Hooking the
/// callback would only ever see the taps that worked.
///
/// `translucent` so the probe registers even when the child declines the hit;
/// `Listener` rather than `GestureDetector` so nothing is consumed.
class TapProbe extends ConsumerWidget {
  const TapProbe({super.key, required this.target, required this.child});

  /// Identifies the control, not the gesture. A funnel key, not a caption.
  final String target;

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => _report(ref, event.pointer),
      child: child,
    );
  }

  void _report(WidgetRef ref, int pointer) {
    try {
      // Before the root listener sees the same pointer: Flutter walks the
      // hit-test path innermost first, which is what lets a coordinate arrive
      // already knowing which control it landed on.
      ref
          .read(tapHeatmapRecorderProvider)
          .onProbe(target: target, pointer: pointer);
      ref
          .read(frictionDetectorProvider)
          .onTap(
            target: target,
            screen: currentScreenName(() => ref.read(kaziRouterProvider)),
          );
    } catch (exception) {
      // Sits on top of a button someone is pressing; measuring the press must
      // never break it.
      Log.error('Failed to report tap on "$target": $exception');
    }
  }
}
