import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/data/sources/ndbc/ndbc_adapter.dart';
import 'package:ai_marine_engine/data/sources/source_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Captures every request the adapter makes and replies with a canned
/// body / status code so we can assert URL composition without ever
/// hitting NDBC.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({this.body = '', this.dioError});

  final String body;
  final DioExceptionType? dioError;

  /// Every request that flowed through this adapter, in order.
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
        Headers.contentTypeHeader: ['text/plain'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
const _farInland = LatLng(latitude: 35.0, longitude: -100.0);
const _bostonStation = BuoyStation(
  id: '44013',
  name: 'Boston Approach',
  lat: 42.346,
  lon: -70.651,
);
const _montaukStation = BuoyStation(
  id: '44017',
  name: 'Montauk Point',
  lat: 40.694,
  lon: -72.048,
);

String _bostonFixture() =>
    File('test/fixtures/http_responses/ndbc_44013.txt').readAsStringSync();

void main() {
  group('NdbcAdapter — station selection', () {
    test('canServe returns true when a station is within the threshold', () {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation, _montaukStation]);
      expect(adapter.canServe(_bostonHarbor, DateTime.now()), isTrue);
    });

    test('canServe returns false beyond the 30 nm threshold', () {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation, _montaukStation]);
      // _farInland is ~hundreds of nm from any seeded station.
      expect(adapter.canServe(_farInland, DateTime.now()), isFalse);
    });

    test('fetch picks the nearest station and uses its id in the URL',
        () async {
      final stub = _StubAdapter(body: _bostonFixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation, _montaukStation]);

      await adapter.fetch(_bostonHarbor, DateTime.utc(2026, 5, 3, 12));

      expect(stub.requests, hasLength(1));
      expect(
        stub.requests.single.uri.toString(),
        'https://www.ndbc.noaa.gov/data/realtime2/44013.txt',
      );
    });
  });

  group('NdbcAdapter — successful fetch', () {
    test('returns a parsed BuoyObservation with provenance metadata', () async {
      final stub = _StubAdapter(body: _bostonFixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);

      final result = await adapter.fetch(
        _bostonHarbor,
        DateTime.utc(2026, 5, 3, 12),
      );

      expect(result.source, DataSource.noaaNdbc);
      expect(result.value.waterTempC, closeTo(8.3, 1e-9));
      expect(result.value.windSpeedMps, closeTo(7.0, 1e-9));
      expect(result.sourceDetails.stationId, '44013');
      expect(result.sourceDetails.interpolationDistanceNm, isNotNull);
      expect(result.confidence, inInclusiveRange(0, 1));
      expect(
        result.validUntil.difference(result.fetchedAt),
        const Duration(minutes: 60),
      );
    });

    test('confidence scales with distance from the station', () async {
      final stub = _StubAdapter(body: _bostonFixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);

      // Right at the station: highest confidence.
      final atStation = await adapter.fetch(
        _bostonStation.location,
        DateTime.utc(2026, 5, 3, 12),
      );
      // 0.25 degree south (~15 nm) of the station: lower confidence.
      final farther = await adapter.fetch(
        const LatLng(latitude: 42.096, longitude: -70.651),
        DateTime.utc(2026, 5, 3, 12),
      );

      expect(atStation.confidence, greaterThan(farther.confidence));
    });
  });

  group('NdbcAdapter — failure modes', () {
    test('no station in range throws SourceException', () async {
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);

      expect(
        () => adapter.fetch(_farInland, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('Dio failure surfaces as SourceException with cause attached',
        () async {
      final dio = Dio()
        ..httpClientAdapter = _StubAdapter(
          dioError: DioExceptionType.connectionTimeout,
        );
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);

      try {
        await adapter.fetch(_bostonHarbor, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.source, DataSource.noaaNdbc);
        expect(e.cause, isA<DioException>());
      }
    });

    test('empty body surfaces as SourceException', () async {
      final dio = Dio()..httpClientAdapter = _StubAdapter(body: '');
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      expect(
        () => adapter.fetch(_bostonHarbor, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('header-only body (no observations) surfaces as SourceException',
        () async {
      final dio = Dio()
        ..httpClientAdapter =
            _StubAdapter(body: '#YY MM DD hh mm\n#yr mo dy hr mn\n');
      final adapter = NdbcAdapter(http: dio)
        ..seedStationsForTesting([_bostonStation]);
      try {
        await adapter.fetch(_bostonHarbor, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.source, DataSource.noaaNdbc);
        expect(e.cause, isA<FormatException>());
      }
    });
  });

  group('NdbcAdapter — bundled station list', () {
    testWidgets('loadStations parses assets/ndbc_stations.json', (
      tester,
    ) async {
      // testWidgets gives us a TestWidgetsFlutterBinding so rootBundle
      // can resolve project assets registered in pubspec.yaml.
      final dio = Dio()..httpClientAdapter = _StubAdapter();
      final adapter = NdbcAdapter(http: dio);
      await adapter.loadStations();
      expect(
        adapter.canServe(_bostonHarbor, DateTime.now()),
        isTrue,
        reason: 'station 44013 should be found within 30 nm of Boston Harbor',
      );
    });
  });
}
