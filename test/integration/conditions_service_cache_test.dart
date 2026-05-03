import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/cache/cache_manager.dart';
import 'package:ai_marine_engine/data/cache/cold_cache.dart';
import 'package:ai_marine_engine/data/cache/hot_cache.dart';
import 'package:ai_marine_engine/data/cache/live_sensor_buffer.dart';
import 'package:ai_marine_engine/data/cache/warm_cache.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/data/sources/ndbc/ndbc_adapter.dart';
import 'package:ai_marine_engine/data/sources/nws_forecast/nws_adapter.dart';
import 'package:ai_marine_engine/data/sources/solunar/solunar_adapter.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_adapter.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

/// HTTP stub that counts calls to each route and returns canned bodies.
/// Lets us assert that a second getWaterTemp() call hits the cache and
/// never re-touches NDBC.
class _CountingStub implements HttpClientAdapter {
  _CountingStub(this.routes);

  final Map<String, String> routes;
  final Map<String, int> callCounts = {};

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    final url = options.uri.toString();
    for (final entry in routes.entries) {
      if (url.contains(entry.key)) {
        callCounts[entry.key] = (callCounts[entry.key] ?? 0) + 1;
        const headers = <String, List<String>>{
          Headers.contentTypeHeader: ['application/json,text/plain'],
        };
        return ResponseBody.fromString(entry.value, 200, headers: headers);
      }
    }
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response<dynamic>(
        requestOptions: options,
        statusCode: 404,
      ),
    );
  }

  @override
  void close({bool force = false}) {}
}

const _bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
const _bostonBuoy = BuoyStation(
  id: '44013',
  name: 'Boston',
  lat: 42.346,
  lon: -70.651,
);

String _ndbcFixture() =>
    File('test/fixtures/http_responses/ndbc_44013.txt').readAsStringSync();

String _nwsPointsFixture() => File(
      'test/fixtures/http_responses/nws_points_42.36_-71.06.json',
    ).readAsStringSync();

String _nwsForecastFixture() => File(
      'test/fixtures/http_responses/nws_forecast_box_71_101.json',
    ).readAsStringSync();

({ConditionsServiceImpl service, _CountingStub stub, AppDatabase db})
    _buildService() {
  final stub = _CountingStub({'/realtime2/': _ndbcFixture()});
  final dio = Dio()..httpClientAdapter = stub;
  final ndbc = NdbcAdapter(http: dio)
    ..seedStationsForTesting(const [_bostonBuoy]);
  final tides = TidesAndCurrentsAdapter(http: dio);
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  final cache = CacheManager(
    live: LiveSensorBuffer(),
    hot: HotCache(),
    warm: WarmCache(dao: db.conditionsCacheDao),
    cold: ColdCache(
      tideDao: db.tideCacheDao,
      forecastDao: db.forecastCacheDao,
    ),
  );
  final service = ConditionsServiceImpl(
    ndbc: ndbc,
    tides: tides,
    nws: NwsAdapter(http: dio),
    solunar: SolunarAdapter(),
    cache: cache,
  );
  return (service: service, stub: stub, db: db);
}

void main() {
  final skipReason = setupSqlite3();

  group('ConditionsService — cache wiring on getWaterTemp', () {
    test(
      'first call writes through to warm; second call hits hot, no NDBC call',
      () async {
        final t = _buildService();
        addTearDown(() => t.db.close());

        final time = DateTime.utc(2026, 5, 3, 12);
        final r1 = await t.service.getWaterTemp(_bostonHarbor, time);
        expect(r1.source, DataSource.noaaNdbc);
        expect(r1.value, closeTo(46.94, 0.01));
        expect(t.stub.callCounts['/realtime2/'], 1);

        // Second call: hot hit short-circuits the network.
        final r2 = await t.service.getWaterTemp(_bostonHarbor, time);
        expect(r2.source, DataSource.noaaNdbc);
        expect(r2.value, closeTo(46.94, 0.01));
        expect(
          t.stub.callCounts['/realtime2/'],
          1,
          reason: 'second call should not re-fetch NDBC',
        );

        // Warm tier should have a row written through on the first call.
        // _locKey rounds -70.55 to -70.6 (Dart's half-away-from-zero).
        final row =
            await t.db.conditionsCacheDao.getByKey('water_temp:42.4,-70.6');
        expect(row, isNotNull);
        expect(row!.dataType, 'water_temp');
        expect(row.source, 'noaa_ndbc');
      },
      skip: skipReason,
    );

    test(
      'unavailable result is not cached — transient miss does not stick',
      () async {
        final t = _buildService();
        addTearDown(() => t.db.close());

        // No NDBC station in range → unavailable, no fetch attempted.
        final r = await t.service.getWaterTemp(
          const LatLng(latitude: 0, longitude: 0),
          DateTime.utc(2026, 5, 3, 12),
        );
        expect(r.source, DataSource.unavailable);

        final row =
            await t.db.conditionsCacheDao.getByKey('water_temp:0.0,0.0');
        expect(
          row,
          isNull,
          reason: 'unavailable should not be persisted to warm',
        );
      },
      skip: skipReason,
    );

    test(
      'preserves provenance (source, stationId, fetchedAt) across cache reads',
      () async {
        final t = _buildService();
        addTearDown(() => t.db.close());

        final time = DateTime.utc(2026, 5, 3, 12);
        final r1 = await t.service.getWaterTemp(_bostonHarbor, time);
        final r2 = await t.service.getWaterTemp(_bostonHarbor, time);

        // Hot hit returns the same envelope; provenance survives.
        expect(r2.source, r1.source);
        expect(r2.sourceDetails.stationId, r1.sourceDetails.stationId);
        expect(r2.fetchedAt, r1.fetchedAt);
        expect(r2.confidence, r1.confidence);
      },
      skip: skipReason,
    );
  });

  group('ConditionsService — cache wiring on getWaves', () {
    test(
      'second call hits hot and skips NDBC; freezed value round-trips',
      () async {
        final t = _buildService();
        addTearDown(() => t.db.close());

        final time = DateTime.utc(2026, 5, 3, 12);
        final r1 = await t.service.getWaves(_bostonHarbor, time);
        expect(r1.source, DataSource.noaaNdbc);
        expect(r1.value, isA<WaveState>());
        expect(r1.value.significantHeightFt, greaterThan(0));
        expect(t.stub.callCounts['/realtime2/'], 1);

        final r2 = await t.service.getWaves(_bostonHarbor, time);
        expect(t.stub.callCounts['/realtime2/'], 1);
        // Freezed value survived encode/decode through warm + hot.
        expect(r2.value.significantHeightFt, r1.value.significantHeightFt);
        expect(r2.value.dominantPeriodSec, r1.value.dominantPeriodSec);
      },
      skip: skipReason,
    );
  });

  group('ConditionsService — cache wiring on getBarometric', () {
    test(
      'second call hits hot and skips NDBC',
      () async {
        final t = _buildService();
        addTearDown(() => t.db.close());

        final time = DateTime.utc(2026, 5, 3, 12);
        final r1 = await t.service.getBarometric(_bostonHarbor, time);
        expect(r1.source, DataSource.noaaNdbc);
        expect(r1.value, isA<BarometricState>());
        expect(r1.value.pressureMillibars, greaterThan(900));
        expect(t.stub.callCounts['/realtime2/'], 1);

        final r2 = await t.service.getBarometric(_bostonHarbor, time);
        expect(t.stub.callCounts['/realtime2/'], 1);
        expect(r2.value.pressureMillibars, r1.value.pressureMillibars);
        expect(r2.value.trend, r1.value.trend);
      },
      skip: skipReason,
    );
  });

  group('ConditionsService — cache wiring on getWind', () {
    test(
      'NWS-served wind: second call hits hot, neither NWS nor NDBC re-fetched',
      () async {
        // Both NWS routes plus NDBC route stubbed; NWS wins on first call.
        final stub = _CountingStub({
          '/points/': _nwsPointsFixture(),
          '/gridpoints/BOX/71,101/forecast': _nwsForecastFixture(),
          '/realtime2/': _ndbcFixture(),
        });
        final dio = Dio()..httpClientAdapter = stub;
        final ndbc = NdbcAdapter(http: dio)
          ..seedStationsForTesting(const [_bostonBuoy]);
        final db = AppDatabase.forTesting(NativeDatabase.memory());
        addTearDown(() => db.close());
        final cache = CacheManager(
          live: LiveSensorBuffer(),
          hot: HotCache(),
          warm: WarmCache(dao: db.conditionsCacheDao),
          cold: ColdCache(
            tideDao: db.tideCacheDao,
            forecastDao: db.forecastCacheDao,
          ),
        );
        final svc = ConditionsServiceImpl(
          ndbc: ndbc,
          tides: TidesAndCurrentsAdapter(http: dio),
          nws: NwsAdapter(http: dio),
          solunar: SolunarAdapter(),
          cache: cache,
        );

        final time = DateTime.utc(2026, 5, 3, 15, 30);
        final r1 = await svc.getWind(_bostonHarbor, time);
        expect(r1.source, DataSource.noaaMarineForecast);
        // Both NWS endpoints were hit (points lookup + grid forecast).
        expect(stub.callCounts['/points/'], 1);
        expect(stub.callCounts['/gridpoints/BOX/71,101/forecast'], 1);
        expect(stub.callCounts['/realtime2/'], isNull);

        final r2 = await svc.getWind(_bostonHarbor, time);
        expect(stub.callCounts['/points/'], 1);
        expect(stub.callCounts['/gridpoints/BOX/71,101/forecast'], 1);
        expect(
          r2.source,
          DataSource.noaaMarineForecast,
          reason: 'cached value retains NWS source',
        );
        expect(r2.value.directionDegrees, r1.value.directionDegrees);
        expect(r2.value.speedKnots, r1.value.speedKnots);
      },
      skip: skipReason,
    );

    test(
      'NDBC fallback on NWS failure: cached value records the NDBC source',
      () async {
        // No NWS routes → SourceException → fall back to NDBC.
        final t = _buildService();
        addTearDown(() => t.db.close());

        final time = DateTime.utc(2026, 5, 3, 12);
        final r1 = await t.service.getWind(_bostonHarbor, time);
        expect(
          r1.source,
          DataSource.noaaNdbc,
          reason: 'NWS missing → NDBC fallback',
        );
        final ndbcCalls1 = t.stub.callCounts['/realtime2/'];
        expect(ndbcCalls1, 1);

        // Second call: hot hit, no further NDBC traffic. The cached
        // ConditionResult.source still reads as NDBC even though the
        // warm row's `source` column was stamped with the preferred
        // 'noaa_marine_forecast'.
        final r2 = await t.service.getWind(_bostonHarbor, time);
        expect(t.stub.callCounts['/realtime2/'], ndbcCalls1);
        expect(r2.source, DataSource.noaaNdbc);
      },
      skip: skipReason,
    );
  });
}
