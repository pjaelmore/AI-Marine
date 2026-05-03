import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/daos/forecast_cache_dao.dart';
import '../database/daos/tide_cache_dao.dart';
import 'hot_cache.dart' show Clock, SystemClock;

/// Tier 3 of the four-layer cache (TDD §2.1.4): per-source long-lived
/// stores for data that's expensive to refetch and stable over hours
/// to days — tide predictions and marine forecasts.
///
/// Both backing tables (`tide_cache`, `forecast_cache`) carry a
/// `pinned` flag. Pinning is how the TripCacheDownloader (later slice)
/// keeps pre-trip data through eviction passes — the user said "I'll
/// be fishing Boston Harbor this weekend" and the app pre-stages
/// tide + forecast for that station/zone, pinned, so a flaky cell
/// connection mid-trip can't strand them.
///
/// Pin semantics:
///   - Pinned + stale: still served. The user pinned it for a reason
///     and stale predictions beat no predictions on a boat with no
///     bars. The CacheManager wraps the response with the cached
///     fetch time so the UI can show "data from yesterday".
///   - Unpinned + stale: deleted on read (same write-through expiry
///     pattern as [WarmCache]) and the caller misses, falling
///     through to the network layer.
///
/// Bulk LRU eviction (`evictUnpinnedTides`, `evictUnpinnedForecasts`)
/// delegates to the DAOs' existing `evictUnpinned(limit)`. The
/// EvictionService (sibling slice) will call these when the cold tier
/// runs over its byte budget; pinned rows are immune.
class ColdCache {
  ColdCache({
    required TideCacheDao tideDao,
    required ForecastCacheDao forecastDao,
    Clock clock = const SystemClock(),
  })  : _tideDao = tideDao,
        _forecastDao = forecastDao,
        _clock = clock;

  final TideCacheDao _tideDao;
  final ForecastCacheDao _forecastDao;
  final Clock _clock;

  // ---- Tide predictions -------------------------------------------------

  Future<String?> getTide({
    required String stationId,
    required String dayBucket,
  }) async {
    final key = _tideKey(stationId, dayBucket);
    final row = await _tideDao.getByKey(key);
    if (row == null) return null;
    final nowMs = _clock.now().millisecondsSinceEpoch;
    final stale = row.validUntilUtc <= nowMs;
    if (stale && !row.pinned) {
      await _tideDao.deleteByKey(key);
      return null;
    }
    await _tideDao.touchLastAccessed(key, nowMs);
    return row.predictionsJson;
  }

  Future<void> putTide({
    required String stationId,
    required String dayBucket,
    required String predictionsJson,
    required Duration ttl,
    bool pinned = false,
  }) async {
    final nowMs = _clock.now().millisecondsSinceEpoch;
    await _tideDao.upsert(
      TideCacheCompanion(
        cacheKey: Value(_tideKey(stationId, dayBucket)),
        stationId: Value(stationId),
        dayBucket: Value(dayBucket),
        predictionsJson: Value(predictionsJson),
        fetchedAtUtc: Value(nowMs),
        validUntilUtc: Value(nowMs + ttl.inMilliseconds),
        sizeBytes: Value(predictionsJson.length),
        lastAccessedUtc: Value(nowMs),
        pinned: Value(pinned),
      ),
    );
  }

  Future<void> setTidePinned({
    required String stationId,
    required String dayBucket,
    required bool pinned,
  }) =>
      _tideDao.setPinned(_tideKey(stationId, dayBucket), pinned: pinned);

  Future<int> evictUnpinnedTides({required int limit}) =>
      _tideDao.evictUnpinned(limit: limit);

  // ---- Marine forecasts -------------------------------------------------

  Future<String?> getForecast({
    required String zoneId,
    required String dayBucket,
  }) async {
    final key = _forecastKey(zoneId, dayBucket);
    final row = await _forecastDao.getByKey(key);
    if (row == null) return null;
    final nowMs = _clock.now().millisecondsSinceEpoch;
    final stale = row.validUntilUtc <= nowMs;
    if (stale && !row.pinned) {
      await _forecastDao.deleteByKey(key);
      return null;
    }
    await _forecastDao.touchLastAccessed(key, nowMs);
    return row.forecastJson;
  }

  Future<void> putForecast({
    required String zoneId,
    required String dayBucket,
    required String forecastJson,
    required Duration ttl,
    bool pinned = false,
  }) async {
    final nowMs = _clock.now().millisecondsSinceEpoch;
    await _forecastDao.upsert(
      ForecastCacheCompanion(
        cacheKey: Value(_forecastKey(zoneId, dayBucket)),
        zoneId: Value(zoneId),
        dayBucket: Value(dayBucket),
        forecastJson: Value(forecastJson),
        fetchedAtUtc: Value(nowMs),
        validUntilUtc: Value(nowMs + ttl.inMilliseconds),
        sizeBytes: Value(forecastJson.length),
        lastAccessedUtc: Value(nowMs),
        pinned: Value(pinned),
      ),
    );
  }

  Future<void> setForecastPinned({
    required String zoneId,
    required String dayBucket,
    required bool pinned,
  }) =>
      _forecastDao.setPinned(
        _forecastKey(zoneId, dayBucket),
        pinned: pinned,
      );

  Future<int> evictUnpinnedForecasts({required int limit}) =>
      _forecastDao.evictUnpinned(limit: limit);

  // ---- Key conventions -------------------------------------------------

  // Human-readable cache keys keep the natural key visible in DB
  // dumps and Sentry breadcrumbs — easier to debug than opaque hashes.
  static String _tideKey(String stationId, String dayBucket) =>
      'tide:$stationId:$dayBucket';

  static String _forecastKey(String zoneId, String dayBucket) =>
      'forecast:$zoneId:$dayBucket';
}
