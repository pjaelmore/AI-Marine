import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/cache/cold_cache.dart';
import 'package:ai_marine_engine/data/cache/trip_cache_downloader.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tide_station.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_adapter.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

class _CountingStub implements HttpClientAdapter {
  _CountingStub(this.body, {this.failures = const <int>{}});

  final String body;
  final Set<int> failures; // call indices (1-based) that should 404

  int callCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    callCount++;
    if (failures.contains(callCount)) {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: options,
          statusCode: 404,
        ),
      );
    }
    const headers = <String, List<String>>{
      Headers.contentTypeHeader: ['application/json'],
    };
    return ResponseBody.fromString(body, 200, headers: headers);
  }

  @override
  void close({bool force = false}) {}
}

const _bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
const _bostonTideStation = TideStation(
  id: '8443970',
  name: 'Boston',
  lat: 42.354,
  lon: -71.052,
);

String _tidesFixture() =>
    File('test/fixtures/http_responses/tides_8443970.json').readAsStringSync();

({TripCacheDownloader downloader, _CountingStub stub, AppDatabase db}) _build({
  Set<int> failures = const <int>{},
}) {
  final stub = _CountingStub(_tidesFixture(), failures: failures);
  final dio = Dio()..httpClientAdapter = stub;
  final tides = TidesAndCurrentsAdapter(http: dio)
    ..seedStationsForTesting(const [_bostonTideStation]);
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  final cold = ColdCache(
    tideDao: db.tideCacheDao,
    forecastDao: db.forecastCacheDao,
  );
  return (
    downloader: TripCacheDownloader(tides: tides, cold: cold),
    stub: stub,
    db: db,
  );
}

void main() {
  final skipReason = setupSqlite3();

  test(
    'downloadTides writes one pinned cold-tier row per UTC day in window',
    () async {
      final t = _build();
      addTearDown(() => t.db.close());

      final stats = await t.downloader.downloadTides(
        location: _bostonHarbor,
        start: DateTime.utc(2026, 5, 22),
        end: DateTime.utc(2026, 5, 24),
      );

      expect(stats.tideStationResolved, isTrue);
      expect(stats.daysAttempted, 3);
      expect(stats.daysSucceeded, 3);
      expect(stats.fullySucceeded, isTrue);
      expect(stats.errors, isEmpty);
      expect(t.stub.callCount, 3);

      for (final day in const ['2026-05-22', '2026-05-23', '2026-05-24']) {
        final row = await t.db.tideCacheDao.getByKey('tide:8443970:$day');
        expect(row, isNotNull, reason: 'expected row for $day');
        expect(row!.pinned, isTrue);
      }
    },
    skip: skipReason,
  );

  test(
    'no station in range: stats report tideStationResolved=false, no fetches',
    () async {
      final t = _build();
      addTearDown(() => t.db.close());

      final stats = await t.downloader.downloadTides(
        location: const LatLng(latitude: 0, longitude: 0),
        start: DateTime.utc(2026, 5, 22),
        end: DateTime.utc(2026, 5, 24),
      );

      expect(stats.tideStationResolved, isFalse);
      expect(stats.daysAttempted, 0);
      expect(stats.fullySucceeded, isFalse);
      expect(t.stub.callCount, 0);
    },
    skip: skipReason,
  );

  test(
    'partial failure: per-day errors accumulate, surviving days are pinned',
    () async {
      // Fail call #2 of 3.
      final t = _build(failures: {2});
      addTearDown(() => t.db.close());

      final stats = await t.downloader.downloadTides(
        location: _bostonHarbor,
        start: DateTime.utc(2026, 5, 22),
        end: DateTime.utc(2026, 5, 24),
      );

      expect(stats.daysAttempted, 3);
      expect(stats.daysSucceeded, 2);
      expect(stats.fullySucceeded, isFalse);
      expect(stats.errors, hasLength(1));
      expect(stats.errors.first.dayBucket, '2026-05-23');

      // Days 1 and 3 succeeded — their rows exist and are pinned.
      expect(
        (await t.db.tideCacheDao.getByKey('tide:8443970:2026-05-22'))?.pinned,
        isTrue,
      );
      expect(
        await t.db.tideCacheDao.getByKey('tide:8443970:2026-05-23'),
        isNull,
      );
      expect(
        (await t.db.tideCacheDao.getByKey('tide:8443970:2026-05-24'))?.pinned,
        isTrue,
      );
    },
    skip: skipReason,
  );

  test(
    'unpinTrip clears the pinned flag for each day in the window',
    () async {
      final t = _build();
      addTearDown(() => t.db.close());

      await t.downloader.downloadTides(
        location: _bostonHarbor,
        start: DateTime.utc(2026, 5, 22),
        end: DateTime.utc(2026, 5, 23),
      );
      // Sanity: pinned after download.
      expect(
        (await t.db.tideCacheDao.getByKey('tide:8443970:2026-05-22'))?.pinned,
        isTrue,
      );

      await t.downloader.unpinTrip(
        location: _bostonHarbor,
        start: DateTime.utc(2026, 5, 22),
        end: DateTime.utc(2026, 5, 23),
      );

      expect(
        (await t.db.tideCacheDao.getByKey('tide:8443970:2026-05-22'))?.pinned,
        isFalse,
      );
      expect(
        (await t.db.tideCacheDao.getByKey('tide:8443970:2026-05-23'))?.pinned,
        isFalse,
      );
    },
    skip: skipReason,
  );

  test(
    'single-day trip: window inclusive on both ends produces one row',
    () async {
      final t = _build();
      addTearDown(() => t.db.close());

      final stats = await t.downloader.downloadTides(
        location: _bostonHarbor,
        start: DateTime.utc(2026, 5, 22),
        end: DateTime.utc(2026, 5, 22),
      );

      expect(stats.daysAttempted, 1);
      expect(t.stub.callCount, 1);
    },
    skip: skipReason,
  );
}
