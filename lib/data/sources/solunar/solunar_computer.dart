import 'dart:math' as math;

import 'package:dart_suncalc/suncalc.dart';
import 'package:dart_suncalc/types.dart' as suncalc;

import '../../../core/types/conditions.dart';
import '../../../core/types/lat_lng.dart';

/// Local computation of sun position, moon phase, and solunar major /
/// minor windows — TDD §5.6.
///
/// No network. The expensive sub-step is the lunar-transit search; we sweep
/// moon altitude at 5-minute resolution across a 50-hour window centred on
/// [time] to bracket the lunar day (~24h50m) and pick out the local altitude
/// maxima. That's ~600 [SunCalc.getMoonPosition] calls per compute. Phase 5's
/// score-grid caches by conditions hash so this cost is amortised across
/// every cell sharing the same hour-bucket of solunar state.
class SolunarComputer {
  const SolunarComputer();

  static const _radToDeg = 180.0 / math.pi;
  static const _majorHalfWindow = Duration(minutes: 60);
  static const _minorHalfWindow = Duration(minutes: 30);

  /// Returns the solunar snapshot for [loc] at [time]. The snapshot's
  /// `majorWindow` and `minorWindow` are filled with the *currently active*
  /// window if any, otherwise the *next upcoming* one within the lookahead
  /// horizon (~24 hours); both are null only if neither applies.
  SolunarState compute(LatLng loc, DateTime time) {
    final t = time.toUtc();
    final sun = SunCalc.getSunPosition(
      t,
      lat: loc.latitude,
      lng: loc.longitude,
    );
    final illum = SunCalc.getMoonIllumination(t);

    final majors = _majorWindows(loc, t);
    final minors = _minorWindows(loc, t);

    return SolunarState(
      sunAltitudeDegrees: sun.altitude * _radToDeg,
      sunAzimuthDegrees: sun.azimuth * _radToDeg,
      moonPhase: phaseFromIlluminationPhase(illum.phase),
      moonIlluminationFraction: illum.fraction,
      majorWindow: _activeOrUpcoming(majors, t),
      minorWindow: _activeOrUpcoming(minors, t),
    );
  }

  /// Major windows: 2-hour spans (±60 min) centred on lunar transit and the
  /// antipode (anti-transit). Returns 2–4 windows bracketing [time].
  List<SolunarWindow> _majorWindows(LatLng loc, DateTime time) {
    final transits = _findLunarTransits(loc, time);
    final out = <SolunarWindow>[];
    for (final centre in transits) {
      out.add(
        SolunarWindow(
          start: centre.subtract(_majorHalfWindow),
          end: centre.add(_majorHalfWindow),
          strength: SolunarStrength.major,
        ),
      );
    }
    out.sort((a, b) => a.start.compareTo(b.start));
    return out;
  }

  /// Minor windows: 1-hour spans (±30 min) centred on moonrise and moonset.
  /// We probe rise/set for the day before, the day of, and the day after
  /// [time] so the search horizon spans ~48 hours.
  List<SolunarWindow> _minorWindows(LatLng loc, DateTime time) {
    final out = <SolunarWindow>[];
    for (final dayOffset in const [-1, 0, 1]) {
      final probe = time.add(Duration(days: dayOffset));
      final mt = SunCalc.getMoonTimes(
        probe,
        lat: loc.latitude,
        lng: loc.longitude,
      );
      for (final centre in [mt.riseDateTime, mt.setDateTime]) {
        if (centre == null) continue;
        out.add(
          SolunarWindow(
            start: centre.subtract(_minorHalfWindow),
            end: centre.add(_minorHalfWindow),
            strength: SolunarStrength.minor,
          ),
        );
      }
    }
    out.sort((a, b) => a.start.compareTo(b.start));
    return out;
  }

  /// Sweeps moon altitude at 5-minute resolution across a 50-hour window
  /// centred on [time] and returns each local altitude maximum (a transit)
  /// plus its anti-transit (12h25m offset, the lunar half-day).
  ///
  /// The lunar day is ~24h50m, so the 50-hour window is guaranteed to
  /// contain at least one transit; with two transits possible at the
  /// edges, we usually get two and produce four windows total.
  List<DateTime> _findLunarTransits(LatLng loc, DateTime time) {
    const stepMinutes = 5;
    const halfWindowHours = 25;
    final start = time.subtract(const Duration(hours: halfWindowHours));
    const samples =
        (halfWindowHours * 2 * 60) ~/ stepMinutes + 1; // ~601 samples
    final altitudes = <double>[];
    final times = <DateTime>[];
    for (var i = 0; i < samples; i++) {
      final t = start.add(Duration(minutes: i * stepMinutes));
      final pos = SunCalc.getMoonPosition(
        t,
        lat: loc.latitude,
        lng: loc.longitude,
      );
      altitudes.add(pos.altitude);
      times.add(t);
    }
    final transits = <DateTime>[];
    // A local maximum at index i requires (i-1) < i > (i+1). Endpoints
    // are skipped — if a true peak sits at the edge, the antipode pulls
    // it back into the next compute() call's window.
    for (var i = 1; i < samples - 1; i++) {
      if (altitudes[i] > altitudes[i - 1] &&
          altitudes[i] > altitudes[i + 1] &&
          // Only transits above horizon — the lunar antipode (below) is
          // produced explicitly below as the 12h25m offset.
          altitudes[i] > 0) {
        transits.add(times[i]);
      }
    }
    // Each transit pairs with an antipode 12h25m offset (lunar half-day).
    const lunarHalfDay = Duration(hours: 12, minutes: 25);
    final all = <DateTime>[
      ...transits,
      ...transits.map((t) => t.add(lunarHalfDay)),
      ...transits.map((t) => t.subtract(lunarHalfDay)),
    ];
    return all..sort();
  }

  /// Picks the active window at [time] if one exists, otherwise the next
  /// upcoming window starting after [time]. Returns null if neither.
  SolunarWindow? _activeOrUpcoming(
    List<SolunarWindow> windows,
    DateTime time,
  ) {
    for (final w in windows) {
      if (w.isActiveAt(time)) return w;
    }
    for (final w in windows) {
      if (w.start.isAfter(time)) return w;
    }
    return null;
  }
}

/// Maps dart_suncalc's normalised lunar phase value (0..1) to the eight
/// canonical phases. `phase` is 0 at new moon, 0.25 first quarter, 0.5
/// full, 0.75 last quarter; buckets are 0.125 wide centred on each named
/// phase. Exposed for direct unit testing.
MoonPhase phaseFromIlluminationPhase(double phase) {
  // Normalise into [0, 1) tolerantly — suncalc keeps it there but we
  // don't want a future change to break this.
  var p = phase % 1.0;
  if (p < 0) p += 1.0;
  if (p < 0.0625 || p >= 0.9375) return MoonPhase.newMoon;
  if (p < 0.1875) return MoonPhase.waxingCrescent;
  if (p < 0.3125) return MoonPhase.firstQuarter;
  if (p < 0.4375) return MoonPhase.waxingGibbous;
  if (p < 0.5625) return MoonPhase.fullMoon;
  if (p < 0.6875) return MoonPhase.waningGibbous;
  if (p < 0.8125) return MoonPhase.lastQuarter;
  return MoonPhase.waningCrescent;
}

// Direct re-export of the third-party Position/Illumination types is
// awkward across version changes; the unused alias below keeps the import
// path explicit so tests can construct types if they want.
// ignore: unused_element
typedef _ScPosition = suncalc.Position;
