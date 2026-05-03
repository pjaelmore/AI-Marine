import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/conditions.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/source_adapter.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tide_station.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({this.body = '', this.dioError});

  final String body;
  final DioExceptionType? dioError;

  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    requests.add(options);
    if (dioError != null) {
      throw DioException(requestOptions: options, type: dioError!);
    }
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
const _farInland = LatLng(latitude: 35.0, longitude: -100.0);
const _bostonStation = TideStation(
  id: '8443970',
  name: 'Boston',
  lat: 42.354,
  lon: -71.052,
);

String _bostonFixture() =>
    File('test/fixtures/http_responses/tides_8443970.json').readAsStringSync();

void main() {
  group('TidesAndCurrentsAdapter — station selection', () {
    test('canServe returns true within the threshold', () {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      expect(adapter.canServe(_bostonHarbor, DateTime.now()), isTrue);
    });

    test('canServe returns false beyond the 60 nm threshold', () {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      expect(adapter.canServe(_farInland, DateTime.now()), isFalse);
    });

    test('fetch issues the spec-shaped request', () async {
      final stub = _StubAdapter(body: _bostonFixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);

      await adapter.fetch(_bostonHarbor, DateTime.utc(2026, 5, 4, 12));

      final req = stub.requests.single;
      expect(
        req.uri.toString(),
        startsWith(
          'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter',
        ),
      );
      expect(req.queryParameters['product'], 'predictions');
      expect(req.queryParameters['station'], '8443970');
      expect(req.queryParameters['datum'], 'MLLW');
      expect(req.queryParameters['time_zone'], 'GMT');
      expect(req.queryParameters['interval'], 'hilo');
      expect(req.queryParameters['format'], 'json');
      // ±1 day around the query time.
      expect(req.queryParameters['begin_date'], '20260503');
      expect(req.queryParameters['end_date'], '20260505');
    });
  });

  group('TidesAndCurrentsAdapter — successful fetch', () {
    test(
        'returns a TideState with phase / next-change / amplitude derived '
        'from real predictions', () async {
      final stub = _StubAdapter(body: _bostonFixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);

      // 08:30 UTC sits between the 05:24 H and 11:49 L → falling.
      final result = await adapter.fetch(
        _bostonHarbor,
        DateTime.utc(2026, 5, 4, 8, 30),
      );
      expect(result.source, DataSource.noaaTidesAndCurrents);
      expect(result.value.phase, TidePhase.falling);
      expect(result.sourceDetails.stationId, '8443970');
      expect(result.confidence, inInclusiveRange(0, 1));
      expect(
        result.validUntil.difference(result.fetchedAt),
        const Duration(minutes: 15),
      );
    });
  });

  group('TidesAndCurrentsAdapter — failure modes', () {
    test('no station in range throws SourceException', () {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      expect(
        () => adapter.fetch(_farInland, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('Dio exception surfaces as SourceException with cause', () async {
      final dio = Dio()
        ..httpClientAdapter = _StubAdapter(
          dioError: DioExceptionType.receiveTimeout,
        );
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      try {
        await adapter.fetch(_bostonHarbor, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.source, DataSource.noaaTidesAndCurrents);
        expect(e.cause, isA<DioException>());
      }
    });

    test('empty body surfaces as SourceException', () {
      final dio = Dio()..httpClientAdapter = _StubAdapter(body: '');
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      expect(
        () => adapter.fetch(_bostonHarbor, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('zero-predictions body surfaces as SourceException', () async {
      final dio = Dio()
        ..httpClientAdapter = _StubAdapter(body: '{"predictions": []}');
      final adapter = TidesAndCurrentsAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      expect(
        () => adapter.fetch(_bostonHarbor, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });
  });

  group('TidesAndCurrentsAdapter — bundled station list', () {
    testWidgets('loadStations parses assets/tide_stations.json', (
      tester,
    ) async {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = TidesAndCurrentsAdapter(http: dio);
      await adapter.loadStations();
      expect(
        adapter.canServe(_bostonHarbor, DateTime.now()),
        isTrue,
        reason: 'station 8443970 should be reachable from Boston Harbor',
      );
    });
  });
}
