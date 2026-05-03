import 'cold_cache.dart';
import 'warm_cache.dart';

/// Counts of rows removed in one [EvictionService.sweep] pass — useful
/// for diagnostics and tests.
class EvictionStats {
  const EvictionStats({
    required this.warmExpired,
    required this.coldTidesExpired,
    required this.coldForecastsExpired,
  });

  final int warmExpired;
  final int coldTidesExpired;
  final int coldForecastsExpired;

  int get total => warmExpired + coldTidesExpired + coldForecastsExpired;
}

/// Coordinates TTL-expiry sweeps across warm and cold caches.
///
/// v1 scope is sweeps only — every cache entry has a TTL, so cache
/// growth is bounded by `insertion_rate × TTL` even without an LRU
/// budget cap. A separate budget-enforcement pass becomes real work
/// only if calibration data shows growth pressure; for now, dropping
/// expired rows on a scheduled tick is sufficient.
///
/// The hot tier doesn't need a sweep: it has its own 30 min idle
/// clear (HotCache._maybeClearOnIdle) and is in-memory anyway. The
/// live tier is a bounded ring buffer per data type — also self-
/// limiting.
///
/// Pinned cold rows survive even when stale. The user pinned them
/// intending to use them offline; serving slightly-stale data beats
/// failing the lookup mid-trip with no signal. The
/// CacheManager.getTide / getForecast read paths already serve
/// pinned-stale rows.
class EvictionService {
  EvictionService({
    required WarmCache warm,
    required ColdCache cold,
  })  : _warm = warm,
        _cold = cold;

  final WarmCache _warm;
  final ColdCache _cold;

  /// Drops expired entries from every Drift-backed tier. Returns
  /// counts for diagnostics. Safe to call concurrently with
  /// readers — Drift serializes writes internally.
  Future<EvictionStats> sweep() async {
    final warmExpired = await _warm.sweepExpired();
    final tidesExpired = await _cold.sweepExpiredTides();
    final forecastsExpired = await _cold.sweepExpiredForecasts();
    return EvictionStats(
      warmExpired: warmExpired,
      coldTidesExpired: tidesExpired,
      coldForecastsExpired: forecastsExpired,
    );
  }
}
