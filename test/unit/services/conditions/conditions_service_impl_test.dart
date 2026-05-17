import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/data/sources/ndbc/ndbc_adapter.dart';
import 'package:ai_marine_engine/data/sources/nws_forecast/nws_adapter.dart';
import 'package:ai_marine_engine/data/sources/open_meteo_marine/open_meteo_marine_adapter.dart';
import 'package:ai_marine_engine/data/sources/open_topo_data/open_topo_data_adapter.dart';
import 'package:ai_marine_engine/data/sources/solunar/solunar_adapter.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tide_station.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_adapter.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _RoutingStub implements HttpClientAdapter {
  _RoutingStub(this.routes);

  /// substring → response body. Lets one stub serve multiple endpoints.
  final Map<String, String> routes;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    final url = options.uri.toString();
    for (final entry in routes.entries) {
      if (url.contains(entry.key)) {
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
const _bostonTideStation = TideStation(
  id: '8443970',
  name: 'Boston',
  lat: 42.354,
  lon: -71.052,
);

String _ndbcFixture() =>
    File('test/fixtures/http_responses/ndbc_44013.txt').readAsStringSync();

/// Buoy reading with WTMP marked missing (`MM`) — wave-only stations,
/// sensor outages, and edge-of-window QC drops all produce this shape.
/// Drives the "fall through to Open-Meteo" code path in `getWaterTemp`.
String _ndbcFixtureNoWtmp() =>
    '#YY  MM DD hh mm WDIR WSPD GST  WVHT   DPD   APD MWD   PRES  ATMP  '
    'WTMP  DEWP  VIS PTDY  TIDE\n'
    '#yr  mo dy hr mn degT m/s  m/s     m   sec   sec degT   hPa  degC  '
    'degC  degC  nmi  hPa    ft\n'
    '2026 05 16 19 00 320  7.0  8.0    MM    MM    MM  MM 1006.1   7.0    '
    'MM   4.5   MM -1.2    MM\n';

/// Open-Meteo Marine response with one sample at the test target hour.
String _openMeteoFixture() => '''
{
  "latitude": 42.36,
  "longitude": -70.55,
  "hourly_units": {"time": "iso8601", "sea_surface_temperature": "°C"},
  "hourly": {
    "time": ["2026-05-16T18:00", "2026-05-16T19:00", "2026-05-16T20:00"],
    "sea_surface_temperature": [26.8, 27.0, 27.2]
  }
}
''';

String _tidesFixture() =>
    File('test/fixtures/http_responses/tides_8443970.json').readAsStringSync();

String _nwsPointsFixture() => File(
      'test/fixtures/http_responses/nws_points_42.36_-71.06.json',
    ).readAsStringSync();

String _nwsForecastFixture() => File(
      'test/fixtures/http_responses/nws_forecast_box_71_101.json',
    ).readAsStringSync();

ConditionsServiceImpl _buildService({
  required Map<String, String> routes,
  bool wireOpenMeteo = false,
  bool wireBathymetry = false,
}) {
  final dio = Dio()..httpClientAdapter = _RoutingStub(routes);
  final ndbc = NdbcAdapter(http: dio)
    ..seedStationsForTesting(const [_bostonBuoy]);
  final tides = TidesAndCurrentsAdapter(http: dio)
    ..seedStationsForTesting(const [_bostonTideStation]);
  final nws = NwsAdapter(http: dio);
  final solunar = SolunarAdapter();
  return ConditionsServiceImpl(
    ndbc: ndbc,
    tides: tides,
    nws: nws,
    solunar: solunar,
    openMeteo: wireOpenMeteo ? OpenMeteoMarineAdapter(http: dio) : null,
    bathymetry: wireBathymetry ? OpenTopoDataAdapter(http: dio) : null,
  );
}

void main() {
  group('getWaterTemp', () {
    test('extracts WTMP from NDBC and converts °C → °F', () async {
      // Boston fixture WTMP = 8.3 °C → 8.3*1.8+32 = 46.94 °F
      final svc = _buildService(routes: {'/realtime2/': _ndbcFixture()});
      final r =
          await svc.getWaterTemp(_bostonHarbor, DateTime.utc(2026, 5, 3, 12));
      expect(r.source, DataSource.noaaNdbc);
      expect(r.unit, 'F');
      expect(r.value, closeTo(46.94, 0.01));
    });

    test('returns unavailable when no NDBC station is in range', () async {
      final svc = _buildService(routes: {});
      final r = await svc.getWaterTemp(
        const LatLng(latitude: 0, longitude: 0),
        DateTime.utc(2026, 5, 3, 12),
      );
      expect(r.source, DataSource.unavailable);
      expect(r.value.isNaN, isTrue);
    });

    test('returns unavailable when NDBC fetch fails', () async {
      final svc = _buildService(routes: {}); // no route → 404 → SourceException
      final r = await svc.getWaterTemp(_bostonHarbor, DateTime.now());
      expect(r.source, DataSource.unavailable);
    });

    test(
      'falls through to Open-Meteo when NDBC returns no WTMP — '
      'this is the offshore-FL case that was silently dropping the row',
      () async {
        final svc = _buildService(
          routes: {
            // NDBC fixture without WTMP — buoy is in range but its
            // latest realtime2 row has no water-temp column.
            '/realtime2/': _ndbcFixtureNoWtmp(),
            // Open-Meteo Marine returns a plausible SST sample.
            'marine-api.open-meteo.com': _openMeteoFixture(),
          },
          wireOpenMeteo: true,
        );
        final r = await svc.getWaterTemp(
          _bostonHarbor,
          DateTime.utc(2026, 5, 16, 19),
        );
        expect(r.source, DataSource.openMeteoMarine);
        // 27.0 °C → 80.6 °F
        expect(r.value, closeTo(80.6, 0.1));
      },
    );

    test(
      'falls through to Open-Meteo when no NDBC station is in range',
      () async {
        final svc = _buildService(
          routes: {
            'marine-api.open-meteo.com': _openMeteoFixture(),
          },
          wireOpenMeteo: true,
        );
        final r = await svc.getWaterTemp(
          const LatLng(latitude: 0, longitude: 0), // mid-Pacific
          DateTime.utc(2026, 5, 16, 19),
        );
        expect(r.source, DataSource.openMeteoMarine);
      },
    );

    test(
      'still returns unavailable when both NDBC and Open-Meteo fail',
      () async {
        // No routes at all → both adapters 404.
        final svc = _buildService(routes: {}, wireOpenMeteo: true);
        final r = await svc.getWaterTemp(
          _bostonHarbor,
          DateTime.utc(2026, 5, 16, 19),
        );
        expect(r.source, DataSource.unavailable);
      },
    );
  });

  group('getTideState', () {
    test('returns the TideState from the Tides & Currents adapter', () async {
      final svc = _buildService(routes: {'/datagetter': _tidesFixture()});
      // 08:30 UTC sits between the 05:24 H and 11:49 L → falling.
      final r = await svc.getTideState(
        _bostonHarbor,
        DateTime.utc(2026, 5, 4, 8, 30),
      );
      expect(r.source, DataSource.noaaTidesAndCurrents);
      expect(r.value.phase, TidePhase.falling);
    });
  });

  group('getWind', () {
    test('prefers NWS when it can serve', () async {
      final routes = {
        '/points/': _nwsPointsFixture(),
        '/gridpoints/BOX/71,101/forecast': _nwsForecastFixture(),
      };
      final svc = _buildService(routes: routes);
      // 15:30 UTC → period 1, "10 mph NW"
      final r =
          await svc.getWind(_bostonHarbor, DateTime.utc(2026, 5, 3, 15, 30));
      expect(r.source, DataSource.noaaMarineForecast);
      expect(r.value.directionDegrees, 315);
      expect(r.value.speedKnots, closeTo(10 * 0.86898, 0.01));
    });

    test('falls back to NDBC when NWS fails', () async {
      // NWS routes deliberately omitted → SourceException → fall back.
      final svc = _buildService(routes: {'/realtime2/': _ndbcFixture()});
      final r = await svc.getWind(_bostonHarbor, DateTime.utc(2026, 5, 3, 12));
      expect(r.source, DataSource.noaaNdbc);
      // Boston buoy: WSPD=7 m/s, WDIR=320 → 7 m/s × 1.94384 ≈ 13.6 kt
      expect(r.value.speedKnots, closeTo(7 * 1.94384, 0.01));
      expect(r.value.directionDegrees, 320);
    });
  });

  group('getWaves', () {
    test('extracts WVHT from NDBC and converts metres → feet', () async {
      // First Boston fixture row has WVHT=MM (missing). Use second row's
      // station context but NDBC parser only takes the first row, so for
      // a populated wave height we need a different fixture. Quickest
      // synthetic: hand-craft a body with a populated row.
      const body =
          '#YY MM DD hh mm WDIR WSPD GST WVHT DPD APD MWD PRES ATMP WTMP DEWP VIS PTDY TIDE\n'
          '#yr mo dy hr mn degT m/s m/s m sec sec degT hPa degC degC degC nmi hPa ft\n'
          '2026 05 03 12 00 220 6.0 8.0 1.5 7 4.0 200 1015.0 17.0 14.0 10.0 MM 0.0 MM\n';
      final svc = _buildService(routes: {'/realtime2/': body});
      final r = await svc.getWaves(_bostonHarbor, DateTime.utc(2026, 5, 3, 12));
      expect(r.source, DataSource.noaaNdbc);
      // 1.5 m × 3.28084 ≈ 4.92 ft
      expect(r.value.significantHeightFt, closeTo(4.92, 0.01));
      expect(r.value.dominantPeriodSec, closeTo(7, 1e-9));
    });

    test('returns unavailable when WVHT is missing in the buoy row', () async {
      // Real Boston fixture has WVHT=MM in the latest row.
      final svc = _buildService(routes: {'/realtime2/': _ndbcFixture()});
      final r = await svc.getWaves(_bostonHarbor, DateTime.utc(2026, 5, 3, 12));
      expect(r.source, DataSource.unavailable);
    });
  });

  group('getSolunar', () {
    test('always returns a result (pure local computation)', () async {
      final svc = _buildService(routes: {});
      final r =
          await svc.getSolunar(_bostonHarbor, DateTime.utc(2026, 5, 22, 18));
      expect(r.source, DataSource.computedLocal);
      expect(r.confidence, 1);
      expect(r.value.moonIlluminationFraction, inInclusiveRange(0, 1));
    });
  });

  group('getBarometric', () {
    test('extracts PRES from NDBC; trend is stable in v1', () async {
      final svc = _buildService(routes: {'/realtime2/': _ndbcFixture()});
      final r =
          await svc.getBarometric(_bostonHarbor, DateTime.utc(2026, 5, 3, 12));
      expect(r.source, DataSource.noaaNdbc);
      expect(r.value.pressureMillibars, closeTo(1006.1, 0.01));
      expect(r.value.trend, BarometricTrend.stable);
      expect(r.value.rateOfChangeMillibarsPerHour, 0);
    });
  });

  group('Phase 3 deferred methods return unavailable', () {
    final svc = _buildService(routes: {});

    test('getCurrent', () async {
      final r = await svc.getCurrent(_bostonHarbor, DateTime.now());
      expect(r.source, DataSource.unavailable);
    });

    test('getDepth with no bathymetry wired stays unavailable', () async {
      // Back-compat: services constructed without bathymetry preserve
      // the Phase 3 behavior so legacy test fixtures keep passing.
      final r = await svc.getDepth(_bostonHarbor);
      expect(r.source, DataSource.unavailable);
    });

    test('getStructure', () async {
      final r = await svc.getStructure(_bostonHarbor);
      expect(r.source, DataSource.unavailable);
      expect(r.value.type, StructureType.unknown);
    });
  });

  group('getDepth — OpenTopoData bathymetry', () {
    String gebcoOcean({num elevation = -45}) => jsonEncode({
          'status': 'OK',
          'results': [
            {
              'elevation': elevation,
              'location': {'lat': 42.36, 'lng': -70.55},
              'dataset': 'gebco2020',
            },
          ],
        });

    String gebcoLand({num elevation = 12}) => jsonEncode({
          'status': 'OK',
          'results': [
            {
              'elevation': elevation,
              'location': {'lat': 42.36, 'lng': -70.55},
              'dataset': 'gebco2020',
            },
          ],
        });

    test(
      'returns depth in feet from GEBCO when wired and the tap is offshore',
      () async {
        final svc = _buildService(
          routes: {'api.opentopodata.org': gebcoOcean(elevation: -45)},
          wireBathymetry: true,
        );
        final r = await svc.getDepth(_bostonHarbor);
        expect(r.source, DataSource.openTopoData);
        expect(r.value, closeTo(147.638, 1e-3)); // 45 m → 147.638 ft
        expect(r.unit, 'ft');
      },
    );

    test(
      'returns unavailable when the GEBCO sample is on land',
      () async {
        final svc = _buildService(
          routes: {'api.opentopodata.org': gebcoLand(elevation: 12)},
          wireBathymetry: true,
        );
        final r = await svc.getDepth(_bostonHarbor);
        // The adapter treats positive elevation as a SourceException so
        // the depth modifier never sees a misleading zero — service
        // surfaces the unavailable placeholder.
        expect(r.source, DataSource.unavailable);
      },
    );

    test(
      'returns unavailable when the GEBCO API fails',
      () async {
        // No route registered → 404 → SourceException → unavailable.
        final svc = _buildService(routes: {}, wireBathymetry: true);
        final r = await svc.getDepth(_bostonHarbor);
        expect(r.source, DataSource.unavailable);
      },
    );
  });

  group('getRecentCatches', () {
    test('returns empty list when no CatchesDao is wired', () async {
      final svc = _buildService(routes: {});
      final result = await svc.getRecentCatches(_bostonHarbor, 5);
      expect(result, isEmpty);
    });
  });
}
