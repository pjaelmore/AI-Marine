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
  late WarmCache cache;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
    cache = WarmCache(dao: db.conditionsCacheDao, clock: clock);
  });

  tearDown(() => db.close());

  group('WarmCache — basic round-trip', () {
    test(
      'put + get returns the stored JSON',
      () async {
        await cache.put(
          key: 'temp:42.36,-70.55',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"value":62.0,"unit":"F"}',
          ttl: const Duration(hours: 1),
        );
        expect(
          await cache.get('temp:42.36,-70.55'),
          '{"value":62.0,"unit":"F"}',
        );
      },
      skip: skipReason,
    );

    test(
      'get on a missing key returns null',
      () async {
        expect(await cache.get('absent'), isNull);
      },
      skip: skipReason,
    );

    test(
      'put replaces the value on a duplicate key',
      () async {
        await cache.put(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"value":60}',
          ttl: const Duration(hours: 1),
        );
        await cache.put(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"value":62}',
          ttl: const Duration(hours: 1),
        );
        expect(await cache.get('k'), '{"value":62}');
      },
      skip: skipReason,
    );
  });

  group('WarmCache — freshness', () {
    test(
      'get returns null and deletes the row once the TTL has passed',
      () async {
        await cache.put(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"v":1}',
          ttl: const Duration(minutes: 30),
        );
        clock.advance(const Duration(minutes: 31));
        expect(await cache.get('k'), isNull);
        // Inline delete: the row is gone, not just hidden.
        expect(await db.conditionsCacheDao.getByKey('k'), isNull);
      },
      skip: skipReason,
    );

    test(
      'get within TTL bumps last_accessed_utc',
      () async {
        await cache.put(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"v":1}',
          ttl: const Duration(hours: 1),
        );
        final fetchedAt = clock.now().millisecondsSinceEpoch;
        clock.advance(const Duration(minutes: 5));

        await cache.get('k');
        final row = await db.conditionsCacheDao.getByKey('k');
        expect(row?.fetchedAtUtc, fetchedAt);
        expect(row?.lastAccessedUtc, clock.now().millisecondsSinceEpoch);
        expect(row!.lastAccessedUtc, greaterThan(row.fetchedAtUtc));
      },
      skip: skipReason,
    );

    test(
      'put stamps valid_until_utc as now + ttl',
      () async {
        const ttl = Duration(hours: 6);
        await cache.put(
          key: 'k',
          dataType: 'forecast',
          source: 'noaa_nws',
          valueJson: '[]',
          ttl: ttl,
        );
        final row = await db.conditionsCacheDao.getByKey('k');
        expect(
          row?.validUntilUtc,
          clock.now().millisecondsSinceEpoch + ttl.inMilliseconds,
        );
      },
      skip: skipReason,
    );
  });

  group('WarmCache — bookkeeping', () {
    test(
      'sumSizeBytes returns the total across rows',
      () async {
        await cache.put(
          key: 'a',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: 'aaaa', // 4 chars
          ttl: const Duration(hours: 1),
        );
        await cache.put(
          key: 'b',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: 'bbbbbb', // 6 chars
          ttl: const Duration(hours: 1),
        );
        expect(await cache.sumSizeBytes(), 10);
      },
      skip: skipReason,
    );

    test(
      'invalidate drops a single key without touching siblings',
      () async {
        await cache.put(
          key: 'a',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"v":1}',
          ttl: const Duration(hours: 1),
        );
        await cache.put(
          key: 'b',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"v":2}',
          ttl: const Duration(hours: 1),
        );
        await cache.invalidate('a');
        expect(await cache.get('a'), isNull);
        expect(await cache.get('b'), '{"v":2}');
      },
      skip: skipReason,
    );
  });
}
