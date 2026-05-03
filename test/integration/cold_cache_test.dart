import 'package:ai_marine_engine/data/cache/cold_cache.dart';
import 'package:ai_marine_engine/data/cache/hot_cache.dart' show Clock;
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
  late ColdCache cache;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
    cache = ColdCache(
      tideDao: db.tideCacheDao,
      forecastDao: db.forecastCacheDao,
      clock: clock,
    );
  });

  tearDown(() => db.close());

  group('ColdCache — tide round-trip', () {
    test(
      'putTide + getTide returns the stored predictions JSON',
      () async {
        await cache.putTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          predictionsJson: '[{"t":"2026-05-22T12:00","v":1.2}]',
          ttl: const Duration(days: 7),
        );
        expect(
          await cache.getTide(stationId: '8443970', dayBucket: '2026-05-22'),
          '[{"t":"2026-05-22T12:00","v":1.2}]',
        );
      },
      skip: skipReason,
    );

    test(
      'getTide on a missing key returns null',
      () async {
        expect(
          await cache.getTide(stationId: 'unknown', dayBucket: '2026-05-22'),
          isNull,
        );
      },
      skip: skipReason,
    );

    test(
      'getTide bumps last_accessed_utc on a fresh hit',
      () async {
        await cache.putTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          predictionsJson: '[]',
          ttl: const Duration(days: 7),
        );
        clock.advance(const Duration(minutes: 5));
        await cache.getTide(stationId: '8443970', dayBucket: '2026-05-22');
        final row = await db.tideCacheDao.getByKey('tide:8443970:2026-05-22');
        expect(row?.lastAccessedUtc, clock.now().millisecondsSinceEpoch);
      },
      skip: skipReason,
    );
  });

  group('ColdCache — pinning overrides TTL', () {
    test(
      'unpinned + stale: getTide deletes the row inline and misses',
      () async {
        await cache.putTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          predictionsJson: '[]',
          ttl: const Duration(hours: 6),
        );
        clock.advance(const Duration(hours: 7));
        expect(
          await cache.getTide(stationId: '8443970', dayBucket: '2026-05-22'),
          isNull,
        );
        expect(
          await db.tideCacheDao.getByKey('tide:8443970:2026-05-22'),
          isNull,
        );
      },
      skip: skipReason,
    );

    test(
      'pinned + stale: getTide still serves the value (offline trip use)',
      () async {
        await cache.putTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          predictionsJson: '[{"t":"x"}]',
          ttl: const Duration(hours: 6),
          pinned: true,
        );
        clock.advance(const Duration(hours: 7));
        expect(
          await cache.getTide(stationId: '8443970', dayBucket: '2026-05-22'),
          '[{"t":"x"}]',
        );
      },
      skip: skipReason,
    );

    test(
      'setTidePinned toggles the pinned flag without touching value',
      () async {
        await cache.putTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          predictionsJson: '[]',
          ttl: const Duration(days: 1),
        );
        await cache.setTidePinned(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          pinned: true,
        );
        var row = await db.tideCacheDao.getByKey('tide:8443970:2026-05-22');
        expect(row?.pinned, isTrue);

        await cache.setTidePinned(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          pinned: false,
        );
        row = await db.tideCacheDao.getByKey('tide:8443970:2026-05-22');
        expect(row?.pinned, isFalse);
      },
      skip: skipReason,
    );
  });

  group('ColdCache — eviction', () {
    test(
      'evictUnpinnedTides drops oldest unpinned by last_accessed; '
      'pinned rows survive',
      () async {
        // Three rows; the middle one is pinned.
        await cache.putTide(
          stationId: 'A',
          dayBucket: '2026-05-20',
          predictionsJson: '[]',
          ttl: const Duration(days: 7),
        );
        clock.advance(const Duration(minutes: 1));
        await cache.putTide(
          stationId: 'B',
          dayBucket: '2026-05-21',
          predictionsJson: '[]',
          ttl: const Duration(days: 7),
          pinned: true,
        );
        clock.advance(const Duration(minutes: 1));
        await cache.putTide(
          stationId: 'C',
          dayBucket: '2026-05-22',
          predictionsJson: '[]',
          ttl: const Duration(days: 7),
        );

        final removed = await cache.evictUnpinnedTides(limit: 5);
        // A and C are unpinned and should both go; B (pinned) survives.
        expect(removed, 2);
        expect(
          await db.tideCacheDao.getByKey('tide:A:2026-05-20'),
          isNull,
        );
        expect(
          await db.tideCacheDao.getByKey('tide:B:2026-05-21'),
          isNotNull,
        );
        expect(
          await db.tideCacheDao.getByKey('tide:C:2026-05-22'),
          isNull,
        );
      },
      skip: skipReason,
    );
  });

  group('ColdCache — forecast round-trip', () {
    test(
      'putForecast + getForecast round-trips the forecast JSON',
      () async {
        await cache.putForecast(
          zoneId: 'ANZ234',
          dayBucket: '2026-05-22',
          forecastJson: '{"periods":[]}',
          ttl: const Duration(hours: 6),
        );
        expect(
          await cache.getForecast(zoneId: 'ANZ234', dayBucket: '2026-05-22'),
          '{"periods":[]}',
        );
      },
      skip: skipReason,
    );

    test(
      'pinned forecast survives TTL expiry and stays available offline',
      () async {
        await cache.putForecast(
          zoneId: 'ANZ234',
          dayBucket: '2026-05-22',
          forecastJson: '{"v":1}',
          ttl: const Duration(hours: 1),
          pinned: true,
        );
        clock.advance(const Duration(hours: 25));
        expect(
          await cache.getForecast(zoneId: 'ANZ234', dayBucket: '2026-05-22'),
          '{"v":1}',
        );
      },
      skip: skipReason,
    );

    test(
      'evictUnpinnedForecasts respects the pinned flag',
      () async {
        await cache.putForecast(
          zoneId: 'ANZ234',
          dayBucket: '2026-05-22',
          forecastJson: '{}',
          ttl: const Duration(hours: 6),
        );
        await cache.putForecast(
          zoneId: 'ANZ235',
          dayBucket: '2026-05-22',
          forecastJson: '{}',
          ttl: const Duration(hours: 6),
          pinned: true,
        );
        final removed = await cache.evictUnpinnedForecasts(limit: 5);
        expect(removed, 1);
        expect(
          await db.forecastCacheDao.getByKey('forecast:ANZ235:2026-05-22'),
          isNotNull,
        );
      },
      skip: skipReason,
    );
  });
}
