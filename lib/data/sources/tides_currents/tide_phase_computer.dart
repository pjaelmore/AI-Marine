import '../../../core/types/conditions.dart';
import 'tide_prediction.dart';

/// Slack-tide window: within this many minutes of a predicted extreme,
/// the phase is reported as slack rather than rising/falling. TDD §5.3.3
/// uses 15 minutes.
const Duration _slackWindow = Duration(minutes: 15);

/// Computes the [TideState] at [time] from a list of bracketing tide
/// extremes — TDD §5.3.3.
///
/// [predictions] should be sorted by time ascending and should bracket
/// [time] (one extreme before, one after). The cache layer is responsible
/// for ensuring this; if the list doesn't bracket [time] this function
/// degrades gracefully by clamping to the first / last prediction.
TideState computeTideStateAt(
  DateTime time,
  List<TidePrediction> predictions,
) {
  if (predictions.isEmpty) {
    throw const FormatException(
      'computeTideStateAt called with empty predictions',
    );
  }
  final before = predictions.lastWhere(
    (p) => !p.time.isAfter(time),
    orElse: () => predictions.first,
  );
  final after = predictions.firstWhere(
    (p) => p.time.isAfter(time),
    orElse: () => predictions.last,
  );

  final TidePhase phase;
  final minsToAfter = after.time.difference(time).inMinutes;
  final minsFromBefore = time.difference(before.time).inMinutes;

  // Spec deviation: TDD §5.3.3 picks the slack name from `before.type`
  // unconditionally, which is wrong when we're slack-close to the *after*
  // extreme (10 min before a high should be slackHigh, not slackLow).
  // Pick from whichever extreme we're actually within the slack window of.
  if (minsFromBefore < _slackWindow.inMinutes) {
    phase = (before.type == TideType.high)
        ? TidePhase.slackHigh
        : TidePhase.slackLow;
  } else if (minsToAfter < _slackWindow.inMinutes) {
    phase = (after.type == TideType.high)
        ? TidePhase.slackHigh
        : TidePhase.slackLow;
  } else if (before.type == TideType.high) {
    phase = TidePhase.falling;
  } else {
    phase = TidePhase.rising;
  }

  return TideState(
    phase: phase,
    toNextChange: after.time.difference(time),
    amplitudeFt: (after.heightFt - before.heightFt).abs(),
  );
}
