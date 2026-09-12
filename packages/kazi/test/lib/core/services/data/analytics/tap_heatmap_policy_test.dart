import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/services/data/analytics/tap_heatmap_policy.dart';

/// Every tap in the app passes through this decision, so the sampling and the
/// ceiling are the only things standing between the heatmap and the event quota.
void main() {
  TapHeatmapPolicy policy({
    bool isEnabled = true,
    int samplePercent = 10,
    int maxEventsPerSession = 300,
  }) => TapHeatmapPolicy.raw(
    isEnabled: isEnabled,
    samplePercent: samplePercent,
    maxEventsPerSession: maxEventsPerSession,
  );

  group('kill switch', () {
    test('captures nothing when disabled', () {
      final disabled = policy(isEnabled: false, samplePercent: 100);

      expect(
        disabled.shouldCaptureAtStart(roll: 0),
        isFalse,
        reason: 'the switch has to beat a 100% band',
      );
    });
  });

  group('sampling band', () {
    test('captures nobody at 0%', () {
      expect(policy(samplePercent: 0).shouldCaptureAtStart(roll: 0), isFalse);
    });

    test('captures everybody at 100%', () {
      final subject = policy(samplePercent: 100);

      for (final roll in [0.0, 0.5, 0.99]) {
        expect(subject.shouldCaptureAtStart(roll: roll), isTrue);
      }
    });

    test('splits at the configured percentage', () {
      final subject = policy();

      expect(subject.shouldCaptureAtStart(roll: 0.09), isTrue);
      expect(subject.shouldCaptureAtStart(roll: 0.1), isFalse);
      expect(subject.shouldCaptureAtStart(roll: 0.99), isFalse);
    });
  });
}
