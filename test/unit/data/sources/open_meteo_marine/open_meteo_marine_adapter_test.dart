import 'dart:convert';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/open_meteo_marine/open_meteo_marine_adapter.dart';
import 'package:ai_marine_engine/data/sources/source_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({this.body, this.dioError});

  final String? body;
  final DioException? dioError;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    requests.add(options);
    final err = dioError;
    if (err != null) throw err;
    final bodyBytes = body == null ? <int>[] : utf8.encode(body!);
    return ResponseBody.fromBytes(
      bodyBytes,
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _fixture({
  List<String> times = const ['2026-05-16T19:00'],
  List<num?> temps = const [27.0],
}) {
  return jsonEncode({
    'latitude': 28.5,
    'longitude': -80.0,
    'hourly_units': {'time': 'iso8601', 'sea_surface_temperature': '°C'},
    'hourly': {
      'time': times,
      'sea_surface_temperature': temps,
    },
  });
}

const _capeCanaveralOffshore = LatLng(latitude: 28.6, longitude: -79.98);

void main() {
  group('OpenMeteoMarineAdapter — wiring', () {
    test('sourceId tags results with `openMeteoMarine`', () {
      final adapter = OpenMeteoMarineAdapter(http: Dio());
      expect(adapter.sourceId, DataSource.openMeteoMarine);
    });

    test('canServe is permissive — global ocean coverage', () {
      final adapter = OpenMeteoMarineAdapter(http: Dio());
      expect(
        adapter.canServe(_capeCanaveralOffshore, DateTime.now()),
        isTrue,
      );
      expect(
        adapter.canServe(
          const LatLng(latitude: 0, longitude: 0),
          DateTime.now(),
        ),
        isTrue,
      );
    });

    test('canServe rejects lat outside [-90, 90]', () {
      final adapter = OpenMeteoMarineAdapter(http: Dio());
      expect(
        adapter.canServe(
          const LatLng(latitude: 91, longitude: 0),
          DateTime.now(),
        ),
        isFalse,
      );
    });
  });

  group('OpenMeteoMarineAdapter — successful fetch', () {
    test('returns SST converted to °F with model-tier confidence', () async {
      final stub = _StubAdapter(body: _fixture(temps: [27.0]));
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenMeteoMarineAdapter(http: dio);

      final r = await adapter.fetch(
        _capeCanaveralOffshore,
        DateTime.utc(2026, 5, 16, 19),
      );

      // 27.0 °C → 80.6 °F
      expect(r.value, closeTo(80.6, 1e-6));
      expect(r.unit, 'F');
      expect(r.source, DataSource.openMeteoMarine);
      // Model-tier confidence sits below the buoy network's 0.5–1.0
      // distance-scaled range; documents that this is a fallback signal.
      expect(r.confidence, lessThan(0.9));
      expect(r.confidence, greaterThan(0.5));
    });

    test('TTL matches the 1-hour cadence of the Marine API', () async {
      final stub = _StubAdapter(body: _fixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenMeteoMarineAdapter(http: dio);

      final r = await adapter.fetch(
        _capeCanaveralOffshore,
        DateTime.utc(2026, 5, 16, 19),
      );
      expect(
        r.validUntil.difference(r.fetchedAt),
        const Duration(hours: 1),
      );
    });

    test('request URL carries lat/lon and the SST hourly field', () async {
      final stub = _StubAdapter(body: _fixture());
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenMeteoMarineAdapter(http: dio);

      await adapter.fetch(
        _capeCanaveralOffshore,
        DateTime.utc(2026, 5, 16, 19),
      );

      expect(stub.requests, hasLength(1));
      final uri = stub.requests.single.uri;
      expect(uri.host, 'marine-api.open-meteo.com');
      expect(uri.queryParameters['latitude'], '28.6000');
      expect(uri.queryParameters['longitude'], '-79.9800');
      expect(uri.queryParameters['hourly'], 'sea_surface_temperature');
      expect(uri.queryParameters['timezone'], 'UTC');
    });
  });

  group('OpenMeteoMarineAdapter — failure modes', () {
    test('empty body surfaces as SourceException', () async {
      final stub = _StubAdapter(body: '');
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenMeteoMarineAdapter(http: dio);

      expect(
        () => adapter.fetch(_capeCanaveralOffshore, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('malformed JSON surfaces as SourceException with cause attached',
        () async {
      final stub = _StubAdapter(body: jsonEncode({'no_hourly': true}));
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenMeteoMarineAdapter(http: dio);

      try {
        await adapter.fetch(_capeCanaveralOffshore, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.source, DataSource.openMeteoMarine);
        expect(e.cause, isA<FormatException>());
      }
    });

    test('Dio failure surfaces as SourceException', () async {
      final stub = _StubAdapter(
        dioError: DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.connectionError,
        ),
      );
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenMeteoMarineAdapter(http: dio);

      expect(
        () => adapter.fetch(_capeCanaveralOffshore, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });
  });
}
