import 'dart:io';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/nws_forecast/nws_adapter.dart';
import 'package:ai_marine_engine/data/sources/source_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _RoutingStub implements HttpClientAdapter {
  _RoutingStub(this.routes);

  /// Map of substring → response body. The first key whose substring
  /// appears in the request URL wins; lets us emulate the points-then-
  /// forecast handoff without hard-coding exact URLs.
  final Map<String, String> routes;

  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    requests.add(options);
    final url = options.uri.toString();
    for (final entry in routes.entries) {
      if (url.contains(entry.key)) {
        return ResponseBody.fromString(
          entry.value,
          200,
          headers: {
            Headers.contentTypeHeader: ['application/json'],
          },
        );
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

String _pointsFixture() => File(
      'test/fixtures/http_responses/nws_points_42.36_-71.06.json',
    ).readAsStringSync();

String _forecastFixture() => File(
      'test/fixtures/http_responses/nws_forecast_box_71_101.json',
    ).readAsStringSync();

void main() {
  group('NwsAdapter — coverage', () {
    test('canServe returns true for US lat/lon', () {
      final dio = Dio()..httpClientAdapter = _RoutingStub({});
      final adapter = NwsAdapter(http: dio);
      expect(adapter.canServe(_bostonHarbor, DateTime.now()), isTrue);
    });

    test('canServe rejects coordinates outside continental US bbox', () {
      final dio = Dio()..httpClientAdapter = _RoutingStub({});
      final adapter = NwsAdapter(http: dio);
      // Mid-Atlantic Ocean
      expect(
        adapter.canServe(
          const LatLng(latitude: 30, longitude: -40),
          DateTime.now(),
        ),
        isFalse,
      );
      // Western Europe
      expect(
        adapter.canServe(
          const LatLng(latitude: 51, longitude: 0),
          DateTime.now(),
        ),
        isFalse,
      );
    });
  });

  group('NwsAdapter — successful two-step lookup', () {
    test('points response routes to forecast URL and returns WindVector',
        () async {
      final stub = _RoutingStub({
        '/points/': _pointsFixture(),
        '/gridpoints/BOX/71,101/forecast': _forecastFixture(),
      });
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NwsAdapter(http: dio);

      // 15:30 UTC sits in period 1 (15:00–16:00 UTC) → "10 mph NW".
      final result = await adapter.fetch(
        _bostonHarbor,
        DateTime.utc(2026, 5, 3, 15, 30),
      );

      expect(result.source, DataSource.noaaMarineForecast);
      expect(result.value.directionDegrees, 315); // NW
      expect(result.value.speedKnots, closeTo(10 * 0.86898, 0.01));
      expect(result.confidence, 0.9);
      expect(
        result.validUntil.difference(result.fetchedAt),
        const Duration(hours: 6),
      );
      expect(stub.requests, hasLength(2));
    });

    test('zone URL is cached after first lookup', () async {
      final stub = _RoutingStub({
        '/points/': _pointsFixture(),
        '/gridpoints/BOX/71,101/forecast': _forecastFixture(),
      });
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NwsAdapter(http: dio);

      await adapter.fetch(_bostonHarbor, DateTime.utc(2026, 5, 3, 15, 30));
      await adapter.fetch(_bostonHarbor, DateTime.utc(2026, 5, 3, 16, 30));

      // First fetch: 1 points + 1 forecast. Second fetch: cache hit on
      // points, 1 forecast → total 3 requests.
      expect(stub.requests.length, 3);
      expect(
        stub.requests.where((r) => r.uri.path.contains('/points/')).length,
        1,
      );
    });

    test('selects the period whose interval contains the query time', () async {
      final stub = _RoutingStub({
        '/points/': _pointsFixture(),
        '/gridpoints/BOX/71,101/forecast': _forecastFixture(),
      });
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NwsAdapter(http: dio);

      // 17:30 UTC → period 3 (17:00–18:00 UTC) → "13 mph NW".
      final r = await adapter.fetch(
        _bostonHarbor,
        DateTime.utc(2026, 5, 3, 17, 30),
      );
      expect(r.value.speedKnots, closeTo(13 * 0.86898, 0.01));
    });
  });

  group('NwsAdapter — failure modes', () {
    test('points lookup error surfaces as SourceException', () async {
      final dio = Dio()..httpClientAdapter = _RoutingStub({});
      final adapter = NwsAdapter(http: dio);
      try {
        await adapter.fetch(_bostonHarbor, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.source, DataSource.noaaMarineForecast);
      }
    });

    test('malformed points response surfaces as SourceException', () async {
      final dio = Dio()
        ..httpClientAdapter = _RoutingStub({
          '/points/': '{"not": "what we expect"}',
        });
      final adapter = NwsAdapter(http: dio);
      try {
        await adapter.fetch(_bostonHarbor, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.cause, isA<FormatException>());
      }
    });

    test('forecast fetch failure surfaces as SourceException', () async {
      // Points succeeds but forecast 404s (no matching route key).
      final stub = _RoutingStub({'/points/': _pointsFixture()});
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NwsAdapter(http: dio);
      try {
        await adapter.fetch(_bostonHarbor, DateTime.now());
        fail('expected SourceException');
      } on SourceException catch (e) {
        expect(e.source, DataSource.noaaMarineForecast);
      }
    });

    test('calm wind in the chosen period surfaces as SourceException',
        () async {
      const calmForecast = '{"properties":{"periods":[{"number":1,'
          '"startTime":"2026-05-03T11:00:00-04:00",'
          '"endTime":"2026-05-03T12:00:00-04:00",'
          '"temperature":52,"temperatureUnit":"F",'
          '"windSpeed":"calm","windDirection":"",'
          '"shortForecast":"Clear"}]}}';
      final stub = _RoutingStub({
        '/points/': _pointsFixture(),
        '/gridpoints/BOX/71,101/forecast': calmForecast,
      });
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = NwsAdapter(http: dio);
      expect(
        () => adapter.fetch(_bostonHarbor, DateTime.utc(2026, 5, 3, 15, 30)),
        throwsA(isA<SourceException>()),
      );
    });
  });
}
