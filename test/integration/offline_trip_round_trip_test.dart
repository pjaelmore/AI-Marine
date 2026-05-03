import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/cache/cache_manager.dart';
import 'package:ai_marine_engine/data/cache/cold_cache.dart';
import 'package:ai_marine_engine/data/cache/hot_cache.dart';
import 'package:ai_marine_engine/data/cache/live_sensor_buffer.dart';
import 'package:ai_marine_engine/data/cache/trip_cache_downloader.dart';
import 'package:ai_marine_engine/data/cache/warm_cache.dart';
import 'package:ai_marine_engine/data/database/app_database.dart';
import 'package:ai_marine_engine/data/sources/ndbc/ndbc_adapter.dart';
import 'package:ai_marine_engine/data/sources/nws_forecast/nws_adapter.dart';
import 'package:ai_marine_engine/data/sources/solunar/solunar_adapter.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tide_station.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_adapter.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helpers/sqlite3_setup.dart';

/// HTTP stub with a switchable "offline" mode. When `offline` is
/// true every call throws — simulates the boat losing cell service.
class _SwitchableStub implements HttpClientAdapter {
  _SwitchableStub(this.body);

  final String body;
  bool offline = false;
  int callCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    callCount++;
    if (offline) {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: 'simulated offline',
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

void main() {
  final skipReason = setupSqlite3();

  test(
    'offline round-trip — Phase 4 DoD: '
    'pin trip → go offline → getTideState still serves cached predictions',
    () async {
      final stub = _SwitchableStub(_tidesFixture());
      final dio = Dio()..httpClientAdapter = stub;
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);

      final tides = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting(const [_bostonTideStation]);
      final cold = ColdCache(
        tideDao: db.tideCacheDao,
        forecastDao: db.forecastCacheDao,
      );
      final cache = CacheManager(
        live: LiveSensorBuffer(),
        hot: HotCache(),
        warm: WarmCache(dao: db.conditionsCacheDao),
        cold: cold,
      );
      final svc = ConditionsServiceImpl(
        ndbc: NdbcAdapter(http: dio),
        tides: tides,
        nws: NwsAdapter(http: dio),
        solunar: SolunarAdapter(),
        cache: cache,
      );
      final downloader = TripCacheDownloader(tides: tides, cold: cold);

      // ── Phase 1: online. User pre-stages a 3-day trip. ──────────
      final downloadStats = await downloader.downloadTides(
        location: _bostonHarbor,
        start: DateTime.utc(2026, 5, 4),
        end: DateTime.utc(2026, 5, 6),
      );
      expect(downloadStats.fullySucceeded, isTrue);
      expect(downloadStats.daysSucceeded, 3);
      final downloadCalls = stub.callCount;
      expect(downloadCalls, 3);

      // ── Phase 2: boat loses signal. ─────────────────────────────
      stub.offline = true;

      // ── Phase 3: getTideState during the trip still works. ──────
      // 08:30 UTC on 2026-05-04 — fixture's bracketing extremes are
      // 05:24 H and 11:49 L → falling. The ColdCache hit avoids the
      // (now offline) network entirely.
      final tideAt0830 = await svc.getTideState(
        _bostonHarbor,
        DateTime.utc(2026, 5, 4, 8, 30),
      );
      expect(tideAt0830.source, DataSource.noaaTidesAndCurrents);
      expect(tideAt0830.value.phase, TidePhase.falling);

      // A different time-of-day on the same UTC bucket also serves
      // from cache — phase computes locally against the cached
      // predictions list.
      final tideAt1400 = await svc.getTideState(
        _bostonHarbor,
        DateTime.utc(2026, 5, 4, 14),
      );
      expect(tideAt1400.source, DataSource.noaaTidesAndCurrents);

      // No additional network calls were made after we went offline.
      expect(
        stub.callCount,
        downloadCalls,
        reason: 'offline path should not have hit the network',
      );

      // ── Phase 4: a query OUTSIDE the pinned window correctly fails. ─
      // 2026-05-10 is past the trip end, no cache entry, network
      // unavailable → unavailable.
      final tideOutside = await svc.getTideState(
        _bostonHarbor,
        DateTime.utc(2026, 5, 10, 12),
      );
      expect(tideOutside.source, DataSource.unavailable);
    },
    skip: skipReason,
  );
}
