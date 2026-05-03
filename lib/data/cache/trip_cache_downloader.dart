import 'dart:convert';

import '../../core/types/lat_lng.dart';
import '../sources/source_adapter.dart' show SourceException;
import '../sources/tides_currents/tides_currents_adapter.dart';
import 'cold_cache.dart';

/// Per-day error captured during a trip download. The downloader
/// continues past per-day failures so a partial download is still
/// useful — the user pinned three days, the network drops on day 4,
/// they still have days 1-3 offline.
class TripDownloadError {
  const TripDownloadError({required this.dayBucket, required this.cause});

  final String dayBucket;
  final Object cause;

  @override
  String toString() => 'TripDownloadError($dayBucket: $cause)';
}

/// Outcome of a single [TripCacheDownloader.downloadTides] call.
class TripDownloadStats {
  const TripDownloadStats({
    required this.tideStationResolved,
    required this.daysAttempted,
    required this.daysSucceeded,
    required this.errors,
  });

  /// True when a tide station was within range of the trip location.
  final bool tideStationResolved;

  final int daysAttempted;
  final int daysSucceeded;
  final List<TripDownloadError> errors;

  /// Whole-trip success: a station resolved and every day fetched.
  bool get fullySucceeded =>
      tideStationResolved && daysSucceeded == daysAttempted;
}

/// Pre-stages tide predictions for a planned trip, pinning the cold-
/// tier rows so an eviction sweep won't drop them mid-trip — TDD
/// §10.4.3.
///
/// Forecasts are deliberately out of scope for this slice. Pre-
/// downloading a marine forecast that's stale by trip day adds little
/// value, and the `getWind` read path doesn't yet consult the cold
/// tier; both items earn their own slice once the integration is
/// designed.
///
/// Per-day failures don't abort the run: each UTC day is fetched
/// independently and accumulated in [TripDownloadStats.errors]. A
/// caller can show "3 of 5 days downloaded, retry on next connection"
/// without losing the partial result.
class TripCacheDownloader {
  TripCacheDownloader({
    required TidesAndCurrentsAdapter tides,
    required ColdCache cold,
  })  : _tides = tides,
        _cold = cold;

  final TidesAndCurrentsAdapter _tides;
  final ColdCache _cold;

  /// Pre-fetches and pins tide predictions for every UTC day in
  /// `[start.toUtc().date, end.toUtc().date]` (inclusive on both
  /// ends). Returns a stats object the UI can render.
  ///
  /// `coldTtl` defaults to 30 days for pinned trips — well past the
  /// 7-day default in [ConditionsServiceImpl.getTideState], but
  /// pinned rows survive eviction regardless of TTL anyway. The
  /// longer TTL only matters if the user unpins the trip mid-window.
  Future<TripDownloadStats> downloadTides({
    required LatLng location,
    required DateTime start,
    required DateTime end,
    Duration coldTtl = const Duration(days: 30),
  }) async {
    final station = _tides.findNearestStation(location);
    if (station == null) {
      return const TripDownloadStats(
        tideStationResolved: false,
        daysAttempted: 0,
        daysSucceeded: 0,
        errors: <TripDownloadError>[],
      );
    }

    final days = _utcDaysBetween(start, end);
    var succeeded = 0;
    final errors = <TripDownloadError>[];

    for (final day in days) {
      final dayBucket = _dayBucket(day);
      try {
        final predictions = await _tides.fetchPredictions(
          station: station,
          time: day,
        );
        await _cold.putTide(
          stationId: station.id,
          dayBucket: dayBucket,
          predictionsJson: jsonEncode(
            predictions.map((p) => p.toJson()).toList(),
          ),
          ttl: coldTtl,
          pinned: true,
        );
        succeeded++;
      } on SourceException catch (e) {
        errors.add(TripDownloadError(dayBucket: dayBucket, cause: e));
      }
    }

    return TripDownloadStats(
      tideStationResolved: true,
      daysAttempted: days.length,
      daysSucceeded: succeeded,
      errors: errors,
    );
  }

  /// Inverse of [downloadTides]: clears the pin on every day in the
  /// window so the next eviction sweep can reclaim those rows. Called
  /// when a user removes a trip plan or the trip end-date passes.
  Future<void> unpinTrip({
    required LatLng location,
    required DateTime start,
    required DateTime end,
  }) async {
    final station = _tides.findNearestStation(location);
    if (station == null) return;
    for (final day in _utcDaysBetween(start, end)) {
      await _cold.setTidePinned(
        stationId: station.id,
        dayBucket: _dayBucket(day),
        pinned: false,
      );
    }
  }

  /// Inclusive list of UTC midnight DateTimes between [start] and
  /// [end] — typically 1-7 entries for a recreational trip.
  List<DateTime> _utcDaysBetween(DateTime start, DateTime end) {
    final su = start.toUtc();
    final eu = end.toUtc();
    final s = DateTime.utc(su.year, su.month, su.day);
    final e = DateTime.utc(eu.year, eu.month, eu.day);
    if (e.isBefore(s)) return const [];
    final days = <DateTime>[];
    var cursor = s;
    while (!cursor.isAfter(e)) {
      days.add(cursor);
      cursor = cursor.add(const Duration(days: 1));
    }
    return days;
  }

  String _dayBucket(DateTime time) {
    final t = time.toUtc();
    final m = t.month.toString().padLeft(2, '0');
    final d = t.day.toString().padLeft(2, '0');
    return '${t.year}-$m-$d';
  }
}
