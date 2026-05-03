import 'package:ai_marine_engine/data/cache/cold_cache.dart';
import 'package:ai_marine_engine/data/cache/eviction_service.dart';
import 'package:ai_marine_engine/data/cache/hot_cache.dart' show Clock;
import 'package:ai_marine_engine/data/cache/warm_cache.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

class _ManualClock implements Clock {
  _ManualClock(this._now);

  DateTime _now;

  @override
  DateTime now() => _now;

  void advance(Duration delta) {
    _now = _now.add(delta);
  }
}

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;
  late _ManualClock clock;
  late WarmCache warm;
  late ColdCache cold;
  late EvictionService eviction;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
    warm = WarmCache(dao: db.conditionsCacheDao, clock: clock);
    cold = ColdCache(
      tideDao: db.tideCacheDao,
      forecastDao: db.forecastCacheDao,
      clock: clock,
    );
    eviction = EvictionService(warm: warm, cold: cold);
  });

  tearDown(() => db.close());

  test(
    'sweep drops only TTL-expired warm rows; fresh ones survive',
    () async {
      await warm.put(
        key: 'fresh',
        dataType: 'water_temp',
        source: 'noaa_ndbc',
        valueJson: '{"v":1}',
        ttl: const Duration(hours: 2),
      );
      await warm.put(
        key: 'stale',
        dataType: 'water_temp',
        source: 'noaa_ndbc',
        valueJson: '{"v":2}',
        ttl: const Duration(minutes: 30),
      );
      clock.advance(const Duration(hours: 1));

      final stats = await eviction.sweep();
      expect(stats.warmExpired, 1);
      expect(stats.coldTidesExpired, 0);
      expect(stats.coldForecastsExpired, 0);
      expect(await db.conditionsCacheDao.getByKey('fresh'), isNotNull);
      expect(await db.conditionsCacheDao.getByKey('stale'), isNull);
    },
    skip: skipReason,
  );

  test(
    'sweep respects pinned cold rows even when stale; unpinned-stale gone',
    () async {
      // Two tide entries: one pinned, one not. Both go stale.
      await cold.putTide(
        stationId: 'PINNED',
        dayBucket: '2026-05-22',
        predictionsJson: '[]',
        ttl: const Duration(minutes: 30),
        pinned: true,
      );
      await cold.putTide(
        stationId: 'UNPIN',
        dayBucket: '2026-05-22',
        predictionsJson: '[]',
        ttl: const Duration(minutes: 30),
      );
      // One forecast entry, unpinned + stale.
      await cold.putForecast(
        zoneId: 'ANZ234',
        dayBucket: '2026-05-22',
        forecastJson: '{}',
        ttl: const Duration(minutes: 30),
      );
      clock.advance(const Duration(hours: 1));

      final stats = await eviction.sweep();
      expect(stats.coldTidesExpired, 1, reason: 'unpinned tide stale → drop');
      expect(stats.coldForecastsExpired, 1);

      // Pinned tide survives even though stale — offline trip case.
      expect(
        await db.tideCacheDao.getByKey('tide:PINNED:2026-05-22'),
        isNotNull,
      );
      expect(
        await db.tideCacheDao.getByKey('tide:UNPIN:2026-05-22'),
        isNull,
      );
      expect(
        await db.forecastCacheDao.getByKey('forecast:ANZ234:2026-05-22'),
        isNull,
      );
    },
    skip: skipReason,
  );

  test(
    'sweep on a clean cache reports zero across the board',
    () async {
      final stats = await eviction.sweep();
      expect(stats.total, 0);
      expect(stats.warmExpired, 0);
      expect(stats.coldTidesExpired, 0);
      expect(stats.coldForecastsExpired, 0);
    },
    skip: skipReason,
  );

  test(
    'a TTL boundary is exclusive on the freshness side: '
    'validUntil == now is treated as expired',
    () async {
      await warm.put(
        key: 'edge',
        dataType: 'water_temp',
        source: 'noaa_ndbc',
        valueJson: '{"v":1}',
        ttl: const Duration(minutes: 30),
      );
      // Advance to exactly the validUntil instant. The DAO query uses
      // `<= now`, so this row is treated as expired. Documents the
      // boundary so a future caller adjusting the operator notices.
      clock.advance(const Duration(minutes: 30));

      final stats = await eviction.sweep();
      expect(stats.warmExpired, 1);
    },
    skip: skipReason,
  );
}
