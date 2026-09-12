import 'dart:math';
import 'dart:ui';

import 'package:kazi/core/services/data/analytics/tap_heatmap_policy.dart';

/// One captured tap, kept for the debug overlay.
class TapPoint {
  const TapPoint({
    required this.screen,
    required this.target,
    required this.x,
    required this.y,
  });

  final String screen;

  /// [TapHeatmapRecorder.noTarget] when the tap reached no probe.
  final String target;

  /// Normalized to the surface, in `[0, 1]`.
  final double x;
  final double y;
}

/// Turns raw pointer-downs into the shape of a heatmap: where on the screen,
/// and on what, aggregated later by `screen` + `target`.
///
/// Pure and push-driven, like `FrictionDetector`: it holds no timers, reports
/// through [onCapture], and never touches an SDK itself.
class TapHeatmapRecorder {
  TapHeatmapRecorder({required this.onCapture, Random? random})
    : _random = random ?? Random();

  /// Written when the tap reached no probe — an absent key would look like a
  /// bug, and these taps are the interesting ones: something the person
  /// believed was a control.
  static const String noTarget = 'none';

  /// Three decimals is ~1px on a phone, and keeps the property's cardinality
  /// low enough to group on.
  static const int _precision = 3;

  /// Called with the event parameters, ready to log.
  final void Function(Map<String, Object> parameters) onCapture;

  final Random _random;

  bool _isSampledIn = false;
  int _captured = 0;
  int _ceiling = 0;

  String? _pendingTarget;
  int? _pendingPointer;

  final List<TapPoint> _points = [];

  /// The session's captured taps, for the debug overlay.
  List<TapPoint> get points => List.unmodifiable(_points);

  bool get isCapturing => _isSampledIn;

  /// The once-per-session dice roll. Returns whether taps are being captured.
  bool applySampling(TapHeatmapPolicy policy) {
    _isSampledIn = policy.shouldCaptureAtStart(roll: _random.nextDouble());
    _ceiling = policy.maxEventsPerSession;
    return _isSampledIn;
  }

  /// A [TapProbe] saw this pointer. Dispatched before [onTap] for the same
  /// gesture, because Flutter walks the hit-test path innermost first.
  void onProbe({required String target, required int pointer}) {
    _pendingTarget = target;
    _pendingPointer = pointer;
  }

  /// The root listener saw the pointer go down at [position] on a [surface].
  void onTap({
    required int pointer,
    required Offset position,
    required Size surface,
    required String screen,
  }) {
    final target = _takeTarget(pointer);

    if (!_isSampledIn || _captured >= _ceiling) return;
    if (surface.width <= 0 || surface.height <= 0) return;

    final point = TapPoint(
      screen: screen,
      target: target,
      x: _normalize(position.dx, surface.width),
      y: _normalize(position.dy, surface.height),
    );

    _captured++;
    _points.add(point);

    onCapture({
      'screen': point.screen,
      'target': point.target,
      'x': point.x,
      'y': point.y,
      'w_bucket': _widthBucket(surface.width),
    });
  }

  /// Consumed whether or not the tap is captured, so a sampled-out session
  /// cannot leave a stale target behind for the next gesture.
  String _takeTarget(int pointer) {
    final target = _pendingPointer == pointer ? _pendingTarget : null;
    _pendingTarget = null;
    _pendingPointer = null;
    return target ?? noTarget;
  }

  static double _normalize(double value, double extent) {
    final ratio = (value / extent).clamp(0.0, 1.0);
    final factor = pow(10, _precision);
    return (ratio * factor).round() / factor;
  }

  /// Groups surfaces whose layout is the same, so one map does not average a
  /// phone and a tablet into a blur.
  static String _widthBucket(double width) => switch (width) {
    < 360 => 'xs',
    < 420 => 'sm',
    < 600 => 'md',
    _ => 'lg',
  };
}
