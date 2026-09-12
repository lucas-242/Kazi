import 'package:flutter/material.dart';
import 'package:kazi/core/routes/current_screen.dart';
import 'package:kazi/injector.dart';
import 'package:kazi_core/kazi_core.dart'
    hide Service, CatalogItem, CatalogItemRepository;

/// Feeds every tap in the app to [TapHeatmapRecorder].
///
/// Mounted from `MaterialApp.builder` rather than above it: the size a tap is
/// normalized against comes from `MediaQuery`, which `WidgetsApp` inserts
/// below itself. Wrapping the app from outside would leave nothing to measure.
///
/// `translucent` and a `Listener` for the same reason as `TapProbe` — the taps
/// worth mapping include the ones no control accepted.
class TapHeatmapListener extends ConsumerWidget {
  const TapHeatmapListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => _report(context, ref, event),
      child: child,
    );
  }

  void _report(BuildContext context, WidgetRef ref, PointerDownEvent event) {
    try {
      ref
          .read(tapHeatmapRecorderProvider)
          .onTap(
            pointer: event.pointer,
            position: event.position,
            surface: MediaQuery.sizeOf(context),
            screen: currentScreenName(() => ref.read(kaziRouterProvider)),
          );
    } catch (exception) {
      // Sits under every gesture in the app; measuring one must never cost it.
      Log.error('Failed to record tap: $exception');
    }
  }
}
