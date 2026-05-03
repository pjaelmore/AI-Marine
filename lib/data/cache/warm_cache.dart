import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/daos/conditions_cache_dao.dart';
import 'hot_cache.dart' show Clock, SystemClock;

/// Tier 2 of the four-layer cache (TDD §2.1.4): a Drift-backed,
/// freshness-aware key/value store for API-derived condition values.
///
/// Where [HotCache] absorbs same-session reads, the warm cache survives
/// app restarts. It's how a user who launches the app a few minutes
/// after closing it still sees the last NDBC water temp without
/// re-hitting the network.
///
/// Values are stored as caller-encoded JSON strings. Keeping the cache
/// type-agnostic at this layer means the eventual `CacheManager` (later
/// slice) decides how each condition shape serializes — the cache
/// itself doesn't have to grow a switch over data types.
///
/// Freshness is enforced on read: a [get] for an entry whose
/// `validUntilUtc` has passed returns `null` AND deletes the row, so a
/// long-lived cache doesn't accumulate stale rows even without a
/// running eviction sweep. Bulk LRU/size-budget eviction is the
/// EvictionService's job and lives in a sibling slice.
class WarmCache {
  WarmCache({
    required ConditionsCacheDao dao,
    Clock clock = const SystemClock(),
  })  : _dao = dao,
        _clock = clock;

  final ConditionsCacheDao _dao;
  final Clock _clock;

  /// Returns the JSON-encoded value at [key] when fresh, or `null` on
  /// miss / expiry. On a fresh hit also bumps `last_accessed_utc` so
  /// LRU eviction can rank rightly.
  Future<String?> get(String key) async {
    final row = await _dao.getByKey(key);
    if (row == null) return null;
    final nowMs = _clock.now().millisecondsSinceEpoch;
    if (row.validUntilUtc <= nowMs) {
      // Stale — drop it inline so the table doesn't grow without
      // bound between eviction passes.
      await _dao.deleteByKey(key);
      return null;
    }
    await _dao.touchLastAccessed(key, nowMs);
    return row.valueJson;
  }

  /// Upserts a fresh entry, stamping `fetched_at_utc = now` and
  /// `valid_until_utc = now + ttl`. The `sizeBytes` we record is the
  /// JSON string's UTF-16 code-unit count — close enough to the
  /// on-disk byte cost for the byte-budget bookkeeping the eviction
  /// service later does.
  Future<void> put({
    required String key,
    required String dataType,
    required String source,
    required String valueJson,
    required Duration ttl,
  }) async {
    final nowMs = _clock.now().millisecondsSinceEpoch;
    await _dao.upsert(
      ConditionsCacheCompanion(
        cacheKey: Value(key),
        dataType: Value(dataType),
        source: Value(source),
        valueJson: Value(valueJson),
        fetchedAtUtc: Value(nowMs),
        validUntilUtc: Value(nowMs + ttl.inMilliseconds),
        sizeBytes: Value(valueJson.length),
        lastAccessedUtc: Value(nowMs),
      ),
    );
  }

  /// Total bytes currently stored — read by the EvictionService when
  /// it decides whether the warm tier is over its budget.
  Future<int> sumSizeBytes() => _dao.sumSizeBytes();

  /// Drops a single key on demand. Used when the caller knows a value
  /// is stale (e.g. after a write to the underlying source) and
  /// doesn't want to wait for TTL.
  Future<void> invalidate(String key) => _dao.deleteByKey(key);
}
