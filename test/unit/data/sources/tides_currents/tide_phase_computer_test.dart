import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tide_phase_computer.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tide_prediction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Boston fixture: 2026-05-04 high 05:24 / low 11:49 / high 18:03 / low 23:55.
  final predictions = [
    TidePrediction(
      time: DateTime.utc(2026, 5, 4, 5, 24),
      heightFt: 10.053,
      type: TideType.high,
    ),
    TidePrediction(
      time: DateTime.utc(2026, 5, 4, 11, 49),
      heightFt: 0.332,
      type: TideType.low,
    ),
    TidePrediction(
      time: DateTime.utc(2026, 5, 4, 18, 3),
      heightFt: 8.858,
      type: TideType.high,
    ),
    TidePrediction(
      time: DateTime.utc(2026, 5, 4, 23, 55),
      heightFt: 1.567,
      type: TideType.low,
    ),
  ];

  group('computeTideStateAt', () {
    test('between high and low: phase is falling', () {
      final state = computeTideStateAt(
        DateTime.utc(2026, 5, 4, 8, 30), // mid-morning, after the 05:24 high
        predictions,
      );
      expect(state.phase, TidePhase.falling);
      expect(state.toNextChange, const Duration(hours: 3, minutes: 19));
      expect(
        state.amplitudeFt,
        closeTo(10.053 - 0.332, 1e-9),
        reason: 'absolute drop between bracketing extremes',
      );
    });

    test('between low and high: phase is rising', () {
      // 14:00 UTC sits between the 11:49 L and 18:03 H.
      final state = computeTideStateAt(
        DateTime.utc(2026, 5, 4, 14),
        predictions,
      );
      expect(state.phase, TidePhase.rising);
    });

    test('within 15 min of an extreme: phase is slack', () {
      // 5 min after the 11:49 low.
      final atSlackLow = computeTideStateAt(
        DateTime.utc(2026, 5, 4, 11, 54),
        predictions,
      );
      expect(atSlackLow.phase, TidePhase.slackLow);

      // 10 min before the 18:03 high.
      final atSlackHigh = computeTideStateAt(
        DateTime.utc(2026, 5, 4, 17, 53),
        predictions,
      );
      expect(atSlackHigh.phase, TidePhase.slackHigh);
    });

    test('exactly at an extreme: phase is slack', () {
      final atHigh = computeTideStateAt(
        DateTime.utc(2026, 5, 4, 5, 24),
        predictions,
      );
      expect(atHigh.phase, TidePhase.slackHigh);
    });

    test('toNextChange counts time to the next extreme, not the previous', () {
      final state = computeTideStateAt(
        DateTime.utc(2026, 5, 4, 7, 0),
        predictions,
      );
      // Next change is the low at 11:49 → 4h 49m away.
      expect(state.toNextChange, const Duration(hours: 4, minutes: 49));
    });

    test('empty predictions list throws FormatException', () {
      expect(
        () => computeTideStateAt(DateTime.utc(2026, 5, 4, 12), const []),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
