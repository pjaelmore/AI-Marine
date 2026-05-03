import 'package:ai_marine_engine/data/cache/cache_manager.dart';
import 'package:ai_marine_engine/data/cache/cold_cache.dart';
import 'package:ai_marine_engine/data/cache/hot_cache.dart';
import 'package:ai_marine_engine/data/cache/live_sensor_buffer.dart';
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

/// Wraps a typed value as JSON. The manager doesn't care about
/// shape — these are just stand-ins for the freezed `toJson` /
/// `fromJson` callers will pass in slice 6.
String _encodeDouble(double v) => '{"v":$v}';
double _decodeDouble(String s) {
  final v = s.replaceAll(RegExp(r'[^\d.\-]'), '');
  return double.parse(v);
}

void main() {
  final skipReason = setupSqlite3();
  late AppDatabase db;
  late _ManualClock clock;
  late LiveSensorBuffer live;
  late HotCache hot;
  late WarmCache warm;
  late ColdCache cold;
  late CacheManager mgr;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    clock = _ManualClock(DateTime.utc(2026, 5, 22, 18));
    live = LiveSensorBuffer(clock: clock);
    hot = HotCache(clock: clock);
    warm = WarmCache(dao: db.conditionsCacheDao, clock: clock);
    cold = ColdCache(
      tideDao: db.tideCacheDao,
      forecastDao: db.forecastCacheDao,
      clock: clock,
    );
    mgr = CacheManager(live: live, hot: hot, warm: warm, cold: cold);
  });

  tearDown(() => db.close());

  group('CacheManager.readLive', () {
    test('returns the live value when fresh and type-matched', () {
      live.record(dataType: 'wind_kt', value: 12.3, source: 'phone');
      expect(
        mgr.readLive<double>('wind_kt', maxAge: const Duration(seconds: 30)),
        12.3,
      );
    });

    test('returns null when no live reading exists', () {
      expect(
        mgr.readLive<double>('wind_kt', maxAge: const Duration(seconds: 30)),
        isNull,
      );
    });

    test('returns null when the live reading is stale', () {
      live.record(dataType: 'wind_kt', value: 12.3, source: 'phone');
      clock.advance(const Duration(minutes: 5));
      expect(
        mgr.readLive<double>('wind_kt', maxAge: const Duration(seconds: 30)),
        isNull,
      );
    });

    test('returns null on type mismatch instead of throwing', () {
      live.record(dataType: 'wind_kt', value: 'not a number', source: 'phone');
      expect(
        mgr.readLive<double>('wind_kt', maxAge: const Duration(seconds: 30)),
        isNull,
      );
    });
  });

  group('CacheManager.readThrough — hot tier', () {
    test(
      'hot hit short-circuits without touching warm or the network',
      () async {
        var fetcherCalls = 0;
        hot.put('water_temp:42.36,-70.55', 62.5);
        final v = await mgr.readThrough<double>(
          key: 'water_temp:42.36,-70.55',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          warmTtl: const Duration(hours: 1),
          encode: _encodeDouble,
          decode: _decodeDouble,
          fetcher: () async {
            fetcherCalls++;
            return 99.0;
          },
        );
        expect(v, 62.5);
        expect(fetcherCalls, 0);
        // Warm should be untouched too.
        expect(
          await db.conditionsCacheDao.getByKey('water_temp:42.36,-70.55'),
          isNull,
        );
      },
      skip: skipReason,
    );
  });

  group('CacheManager.readThrough — warm tier', () {
    test(
      'warm hit decodes, promotes to hot, and skips the fetcher',
      () async {
        var fetcherCalls = 0;
        await warm.put(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          valueJson: '{"v":62.5}',
          ttl: const Duration(hours: 1),
        );
        final v = await mgr.readThrough<double>(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          warmTtl: const Duration(hours: 1),
          encode: _encodeDouble,
          decode: _decodeDouble,
          fetcher: () async {
            fetcherCalls++;
            return 99.0;
          },
        );
        expect(v, 62.5);
        expect(fetcherCalls, 0);
        expect(
          hot.getAs<double>('k'),
          62.5,
          reason: 'warm hit should promote to hot',
        );
      },
      skip: skipReason,
    );
  });

  group('CacheManager.readThrough — network tier', () {
    test(
      'all-miss falls through to fetcher and writes through to warm + hot',
      () async {
        final v = await mgr.readThrough<double>(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          warmTtl: const Duration(hours: 1),
          encode: _encodeDouble,
          decode: _decodeDouble,
          fetcher: () async => 62.5,
        );
        expect(v, 62.5);
        expect(
          hot.getAs<double>('k'),
          62.5,
          reason: 'network fill should populate hot',
        );
        final row = await db.conditionsCacheDao.getByKey('k');
        expect(row?.valueJson, '{"v":62.5}');
        expect(row?.dataType, 'water_temp');
        expect(row?.source, 'noaa_ndbc');
      },
      skip: skipReason,
    );

    test(
      'fetcher returning null leaves the caches untouched',
      () async {
        final v = await mgr.readThrough<double>(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          warmTtl: const Duration(hours: 1),
          encode: _encodeDouble,
          decode: _decodeDouble,
          fetcher: () async => null,
        );
        expect(v, isNull);
        expect(hot.getAs<double>('k'), isNull);
        expect(await db.conditionsCacheDao.getByKey('k'), isNull);
      },
      skip: skipReason,
    );

    test(
      'second call after a network fill skips the fetcher (hot hit)',
      () async {
        var fetcherCalls = 0;
        Future<double?> fetch() async {
          fetcherCalls++;
          return 62.5;
        }

        await mgr.readThrough<double>(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          warmTtl: const Duration(hours: 1),
          encode: _encodeDouble,
          decode: _decodeDouble,
          fetcher: fetch,
        );
        await mgr.readThrough<double>(
          key: 'k',
          dataType: 'water_temp',
          source: 'noaa_ndbc',
          warmTtl: const Duration(hours: 1),
          encode: _encodeDouble,
          decode: _decodeDouble,
          fetcher: fetch,
        );
        expect(fetcherCalls, 1);
      },
      skip: skipReason,
    );
  });

  group('CacheManager.getTide — cold-tier read-through', () {
    test(
      'cold hit returns the JSON and promotes to hot',
      () async {
        await cold.putTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          predictionsJson: '[{"t":"x"}]',
          ttl: const Duration(days: 7),
        );
        final v = await mgr.getTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          coldTtl: const Duration(days: 7),
          fetcher: () async => fail('cold hit should not call fetcher'),
        );
        expect(v, '[{"t":"x"}]');
        expect(hot.getAs<String>('tide:8443970:2026-05-22'), '[{"t":"x"}]');
      },
      skip: skipReason,
    );

    test(
      'all-miss fetches and writes through to cold + hot',
      () async {
        final v = await mgr.getTide(
          stationId: '8443970',
          dayBucket: '2026-05-22',
          coldTtl: const Duration(days: 7),
          fetcher: () async => '[{"t":"fresh"}]',
        );
        expect(v, '[{"t":"fresh"}]');
        expect(hot.getAs<String>('tide:8443970:2026-05-22'), '[{"t":"fresh"}]');
        expect(
          (await db.tideCacheDao.getByKey('tide:8443970:2026-05-22'))
              ?.predictionsJson,
          '[{"t":"fresh"}]',
        );
      },
      skip: skipReason,
    );
  });

  group('CacheManager.getForecast — cold-tier read-through', () {
    test(
      'all-miss fetches, writes through, and a second call hits hot',
      () async {
        var fetcherCalls = 0;
        Future<String?> fetch() async {
          fetcherCalls++;
          return '{"periods":[]}';
        }

        await mgr.getForecast(
          zoneId: 'ANZ234',
          dayBucket: '2026-05-22',
          coldTtl: const Duration(hours: 6),
          fetcher: fetch,
        );
        await mgr.getForecast(
          zoneId: 'ANZ234',
          dayBucket: '2026-05-22',
          coldTtl: const Duration(hours: 6),
          fetcher: fetch,
        );
        expect(fetcherCalls, 1, reason: 'second call should hit hot');
        expect(
          (await db.forecastCacheDao.getByKey('forecast:ANZ234:2026-05-22'))
              ?.forecastJson,
          '{"periods":[]}',
        );
      },
      skip: skipReason,
    );
  });
}
