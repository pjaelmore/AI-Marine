import 'cold_cache.dart';
import 'hot_cache.dart';
import 'live_sensor_buffer.dart';
import 'warm_cache.dart';

/// Orchestrates the four cache tiers in TDD §2.1.4 read precedence:
/// live → hot → warm → cold → network.
///
/// The manager itself stays type-agnostic. Each call site supplies
/// the encode/decode functions and the network fetcher; the manager
/// owns the precedence dance, the write-through promotion on cache
/// fills, and the live-tier short-circuit.
///
/// Cleavage between [readThrough] (warm) and [getTide] / [getForecast]
/// (cold) is deliberate: warm is fungible JSON keyed by a free-form
/// string (water temp, wind, waves, …); cold is per-source bulky
/// predictions keyed by their natural `(stationId|zoneId, dayBucket)`
/// key and carries the `pinned` flag for offline trip use. They have
/// genuinely different lifetimes and shapes, so collapsing them
/// behind one method would force a switch over data type and lose
/// the pin semantics.
///
/// Live-tier consultation is the caller's choice via [readLive]. The
/// manager doesn't bake it into [readThrough] because the live tier
/// only meaningfully applies to lookups at the *user's* location —
/// a NMEA wind reading from your boat doesn't apply to a wind
/// lookup at a spot 30 nm away. The caller is responsible for the
/// "is this lookup at my location?" check before consulting live.
class CacheManager {
  CacheManager({
    required LiveSensorBuffer live,
    required HotCache hot,
    required WarmCache warm,
    required ColdCache cold,
  })  : _live = live,
        _hot = hot,
        _warm = warm,
        _cold = cold;

  final LiveSensorBuffer _live;
  final HotCache _hot;
  final WarmCache _warm;
  final ColdCache _cold;

  /// Tier-0 lookup. Returns the latest reading for [dataType] iff it
  /// is within [maxAge] AND its value is a [T]. Type-mismatch returns
  /// null so a stale `wind` reading shaped differently from what the
  /// caller expects fails silently rather than crashing.
  T? readLive<T>(String dataType, {required Duration maxAge}) {
    final reading = _live.latest(dataType, maxAge: maxAge);
    final value = reading?.value;
    return value is T ? value : null;
  }

  /// Generic warm-tier read-through with hot promotion.
  ///
  /// Tries:
  ///   1. Hot ([HotCache.getAs]<T>(key)) — same-session hit.
  ///   2. Warm ([WarmCache.get](key)) — decode + promote to hot.
  ///   3. Network (`fetcher()`) — encode + write to warm + hot.
  ///
  /// Returns null if all three miss. Encode and decode bracket the
  /// JSON serialization the warm cache requires; the manager doesn't
  /// know the value's shape.
  Future<T?> readThrough<T>({
    required String key,
    required String dataType,
    required String source,
    required Duration warmTtl,
    required String Function(T value) encode,
    required T Function(String json) decode,
    required Future<T?> Function() fetcher,
  }) async {
    // 1. Hot.
    final hotHit = _hot.getAs<T>(key);
    if (hotHit != null) return hotHit;

    // 2. Warm.
    final warmJson = await _warm.get(key);
    if (warmJson != null) {
      final value = decode(warmJson);
      _hot.put(key, value);
      return value;
    }

    // 3. Network.
    final fresh = await fetcher();
    if (fresh != null) {
      _hot.put(key, fresh);
      await _warm.put(
        key: key,
        dataType: dataType,
        source: source,
        valueJson: encode(fresh),
        ttl: warmTtl,
      );
    }
    return fresh;
  }

  /// Cold-tier read-through for tide predictions. The hot cache uses
  /// the canonical cache key shape `tide:<station>:<day>` so a second
  /// in-session lookup of the same station/day skips Drift entirely.
  Future<String?> getTide({
    required String stationId,
    required String dayBucket,
    required Duration coldTtl,
    required Future<String?> Function() fetcher,
  }) async {
    final hotKey = 'tide:$stationId:$dayBucket';

    final hotHit = _hot.getAs<String>(hotKey);
    if (hotHit != null) return hotHit;

    final coldHit =
        await _cold.getTide(stationId: stationId, dayBucket: dayBucket);
    if (coldHit != null) {
      _hot.put(hotKey, coldHit);
      return coldHit;
    }

    final fresh = await fetcher();
    if (fresh != null) {
      _hot.put(hotKey, fresh);
      await _cold.putTide(
        stationId: stationId,
        dayBucket: dayBucket,
        predictionsJson: fresh,
        ttl: coldTtl,
      );
    }
    return fresh;
  }

  /// Cold-tier read-through for marine forecasts. Same shape as
  /// [getTide] with the `forecast:<zone>:<day>` hot key convention.
  Future<String?> getForecast({
    required String zoneId,
    required String dayBucket,
    required Duration coldTtl,
    required Future<String?> Function() fetcher,
  }) async {
    final hotKey = 'forecast:$zoneId:$dayBucket';

    final hotHit = _hot.getAs<String>(hotKey);
    if (hotHit != null) return hotHit;

    final coldHit =
        await _cold.getForecast(zoneId: zoneId, dayBucket: dayBucket);
    if (coldHit != null) {
      _hot.put(hotKey, coldHit);
      return coldHit;
    }

    final fresh = await fetcher();
    if (fresh != null) {
      _hot.put(hotKey, fresh);
      await _cold.putForecast(
        zoneId: zoneId,
        dayBucket: dayBucket,
        forecastJson: fresh,
        ttl: coldTtl,
      );
    }
    return fresh;
  }
}
