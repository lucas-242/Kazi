import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_policy.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_recorder.dart';

/// The recorder is what keeps a heatmap from costing an event per pointer-down
/// for every user forever, and what decides whether a coordinate arrives
/// knowing which control it hit.
void main() {
  const surface = Size(400, 800);

  late List<Map<String, Object>> captured;

  TapHeatmapRecorder recorder({
    bool isEnabled = true,
    int samplePercent = 100,
    int maxEventsPerSession = 300,
    double roll = 0,
  }) {
    final subject = TapHeatmapRecorder(
      onCapture: captured.add,
      random: _FixedRandom(roll),
    );
    subject.applySampling(
      TapHeatmapPolicy.raw(
        isEnabled: isEnabled,
        samplePercent: samplePercent,
        maxEventsPerSession: maxEventsPerSession,
      ),
    );
    return subject;
  }

  void tap(
    TapHeatmapRecorder subject, {
    int pointer = 1,
    Offset position = const Offset(200, 400),
    String screen = 'home',
  }) => subject.onTap(
    pointer: pointer,
    position: position,
    surface: surface,
    screen: screen,
  );

  setUp(() => captured = []);

  group('sampling', () {
    test('captures nothing when the session was sampled out', () {
      tap(recorder(samplePercent: 0));

      expect(captured, isEmpty);
    });

    test('captures nothing before any sampling decision', () {
      // The recorder comes up silent, which is what makes skipping the roll in
      // the bootstrap a valid way to honour a withheld consent.
      final untouched = TapHeatmapRecorder(onCapture: captured.add);

      tap(untouched);

      expect(captured, isEmpty);
      expect(untouched.isCapturing, isFalse);
    });
  });

  group('normalization', () {
    test('reports the position as a fraction of the surface', () {
      tap(recorder(), position: const Offset(100, 200));

      expect(captured.single['x'], 0.25);
      expect(captured.single['y'], 0.25);
    });

    test('clamps a position outside the surface', () {
      tap(recorder(), position: const Offset(-20, 1600));

      expect(captured.single['x'], 0);
      expect(captured.single['y'], 1);
    });

    test('ignores a surface with no extent', () {
      recorder().onTap(
        pointer: 1,
        position: Offset.zero,
        surface: Size.zero,
        screen: 'home',
      );

      expect(captured, isEmpty, reason: 'nothing to normalize against');
    });
  });

  group('target pairing', () {
    test('a tap with no probe is reported as untargeted', () {
      tap(recorder());

      expect(captured.single['target'], TapHeatmapRecorder.noTarget);
    });

    test('a probe on the same pointer names the control', () {
      final subject = recorder();

      subject.onProbe(target: 'save_service', pointer: 7);
      tap(subject, pointer: 7);

      expect(captured.single['target'], 'save_service');
    });

    test('a probe does not leak onto the next gesture', () {
      final subject = recorder();

      subject.onProbe(target: 'save_service', pointer: 7);
      tap(subject, pointer: 7);
      tap(subject, pointer: 8);

      expect(captured.last['target'], TapHeatmapRecorder.noTarget);
    });

    test('a probe from a different pointer is not borrowed', () {
      final subject = recorder();

      subject.onProbe(target: 'save_service', pointer: 7);
      tap(subject, pointer: 9);

      expect(captured.single['target'], TapHeatmapRecorder.noTarget);
    });

    test('a stale probe is dropped by a sampled-out session too', () {
      final subject = recorder(samplePercent: 0);

      subject.onProbe(target: 'save_service', pointer: 7);
      tap(subject, pointer: 7);

      // Nothing was captured, but the slot must still be clear: the roll is per
      // session, so a stale target would otherwise outlive every gesture.
      expect(captured, isEmpty);
    });
  });

  group('session ceiling', () {
    test('stops capturing once the ceiling is reached', () {
      final subject = recorder(maxEventsPerSession: 2);

      for (var pointer = 0; pointer < 5; pointer++) {
        tap(subject, pointer: pointer);
      }

      expect(captured, hasLength(2));
      expect(subject.points, hasLength(2));
    });
  });

  test('keeps the session points for the debug overlay', () {
    final subject = recorder();

    tap(subject, position: const Offset(100, 200), screen: 'services');

    expect(subject.points.single.screen, 'services');
    expect(subject.points.single.x, 0.25);
  });
}

/// Returns the same roll every time, so the sampling band is the only variable.
class _FixedRandom implements Random {
  _FixedRandom(this._value);

  final double _value;

  @override
  double nextDouble() => _value;

  @override
  bool nextBool() => throw UnimplementedError();

  @override
  int nextInt(int max) => throw UnimplementedError();
}
