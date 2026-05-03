import 'dart:collection';

import 'hot_cache.dart' show Clock, SystemClock;

/// One reading captured from a live-sensor source.
class LiveReading {
  const LiveReading({
    required this.value,
    required this.timestampUtc,
    required this.source,
  });

  /// Caller-typed payload. The buffer is type-agnostic by design —
  /// callers know what shape they pushed and unwrap accordingly.
  final Object? value;

  final DateTime timestampUtc;

  /// Free-form source tag. v1 examples: 'phone_barometer',
  /// 'phone_gps', and (Phase 7) 'nmea_2000'.
  final String source;
}

/// Tier 0 of the four-layer cache (TDD §2.1.4): an in-memory ring
/// buffer for live-sensor readings.
///
/// In v1 nothing is wired to push into this layer — NMEA 2000 lands
/// in Phase 7. It's built now because the CacheManager's read
/// precedence (live → hot → warm → cold → network) needs a stable
/// live-tier interface; without it, every Phase 7 NMEA wire-up would
/// force a CacheManager refactor.
///
/// Per-type capacity defaults to 64 readings — enough to compute
/// short-window derivatives like a barometric trend over the last
/// hour, while staying small enough that an idle session doesn't
/// hold thousands of orphaned samples.
///
/// Freshness is the caller's call: [latest] takes a `maxAge` and
/// returns null if the most recent reading is older than that. This
/// matches the spec's "live takes precedence iff actually live"
/// semantics — a stale GPS fix from when you were docked shouldn't
/// override the warm cache's current condition lookup.
class LiveSensorBuffer {
  LiveSensorBuffer({
    int perTypeCapacity = 64,
    Clock clock = const SystemClock(),
  })  : _capacity = perTypeCapacity,
        _clock = clock;

  final int _capacity;
  final Clock _clock;
  final Map<String, ListQueue<LiveReading>> _buffers =
      <String, ListQueue<LiveReading>>{};

  /// Records a reading at `now`. Drops the oldest if the per-type
  /// buffer would exceed [_capacity].
  void record({
    required String dataType,
    required Object? value,
    required String source,
  }) {
    final buf = _buffers.putIfAbsent(dataType, ListQueue<LiveReading>.new);
    if (buf.length >= _capacity) buf.removeFirst();
    buf.addLast(
      LiveReading(
        value: value,
        timestampUtc: _clock.now(),
        source: source,
      ),
    );
  }

  /// The most recent reading for [dataType] iff it is within
  /// [maxAge] of `now`. Returns null when no reading of that type
  /// exists or the latest is too old to count as "live".
  LiveReading? latest(String dataType, {required Duration maxAge}) {
    final buf = _buffers[dataType];
    if (buf == null || buf.isEmpty) return null;
    final reading = buf.last;
    if (_clock.now().difference(reading.timestampUtc) > maxAge) return null;
    return reading;
  }

  /// Readings within [window], chronological order (oldest first).
  /// Useful for short-horizon trend calculations like barometric
  /// trend or wind-shift detection.
  List<LiveReading> recent(String dataType, {required Duration window}) {
    final buf = _buffers[dataType];
    if (buf == null || buf.isEmpty) return const [];
    final cutoff = _clock.now().subtract(window);
    return buf.where((r) => r.timestampUtc.isAfter(cutoff)).toList();
  }

  /// Number of buffered readings for [dataType] — for diagnostics
  /// and tests.
  int sizeOf(String dataType) => _buffers[dataType]?.length ?? 0;

  /// Drops every buffered reading. Called by the app shell on
  /// background so a backgrounded NMEA session doesn't surface
  /// hours-old readings on resume.
  void clear() => _buffers.clear();
}
