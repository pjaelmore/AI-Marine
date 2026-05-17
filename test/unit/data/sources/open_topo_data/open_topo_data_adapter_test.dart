import 'dart:convert';
import 'dart:typed_data';

import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/open_topo_data/open_topo_data_adapter.dart';
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
    final bytes = body == null ? <int>[] : utf8.encode(body!);
    return ResponseBody.fromBytes(
      bytes,
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _fixture({num? elevation = -45, String status = 'OK'}) {
  return jsonEncode({
    'status': status,
    'results': [
      {
        'elevation': elevation,
        'location': {'lat': 28.5, 'lng': -80.0},
        'dataset': 'gebco2020',
      },
    ],
  });
}

const _capeCanaveralOffshore = LatLng(latitude: 28.6, longitude: -79.98);

void main() {
  group('OpenTopoDataAdapter — wiring', () {
    test('sourceId tags results with `openTopoData`', () {
      final adapter = OpenTopoDataAdapter(http: Dio());
      expect(adapter.sourceId, DataSource.openTopoData);
    });

    test('defaultTtl is 1 day — bathymetry is essentially static', () {
      final adapter = OpenTopoDataAdapter(http: Dio());
      expect(adapter.defaultTtl, const Duration(days: 1));
    });

    test('canServe accepts any valid lat/lon', () {
      final adapter = OpenTopoDataAdapter(http: Dio());
      expect(
        adapter.canServe(_capeCanaveralOffshore, DateTime.now()),
        isTrue,
      );
    });
  });

  group('OpenTopoDataAdapter — successful fetch', () {
    test('converts negative metres to positive feet depth', () async {
      // -45 m → 45 m → 147.638 ft
      final stub = _StubAdapter(body: _fixture(elevation: -45));
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenTopoDataAdapter(http: dio);

      final r = await adapter.fetch(_capeCanaveralOffshore, DateTime.now());
      expect(r.value, closeTo(147.638, 1e-3));
      expect(r.unit, 'ft');
      expect(r.source, DataSource.openTopoData);
    });

    test('model-tier confidence (lower than buoy network)', () async {
      final stub = _StubAdapter(body: _fixture(elevation: -100));
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenTopoDataAdapter(http: dio);

      final r = await adapter.fetch(_capeCanaveralOffshore, DateTime.now());
      expect(r.confidence, lessThan(0.9));
      expect(r.confidence, greaterThan(0.5));
    });

    test('request URL carries the locations parameter', () async {
      final stub = _StubAdapter(body: _fixture(elevation: -45));
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenTopoDataAdapter(http: dio);

      await adapter.fetch(_capeCanaveralOffshore, DateTime.now());
      expect(stub.requests, hasLength(1));
      final uri = stub.requests.single.uri;
      expect(uri.host, 'api.opentopodata.org');
      expect(uri.queryParameters['locations'], '28.6000,-79.9800');
    });
  });

  group('OpenTopoDataAdapter — failure modes', () {
    test('land tap (positive elevation) surfaces as SourceException', () async {
      // Mid-Florida — GEBCO returns positive metres. The adapter must
      // not hand back a "0 ft depth" reading; that would feed a
      // nonsensical zero into the depth modifier.
      final stub = _StubAdapter(body: _fixture(elevation: 12));
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenTopoDataAdapter(http: dio);

      expect(
        () => adapter.fetch(_capeCanaveralOffshore, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('non-OK status surfaces as SourceException', () async {
      final stub = _StubAdapter(
        body: _fixture(elevation: -45, status: 'INVALID_REQUEST'),
      );
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenTopoDataAdapter(http: dio);

      expect(
        () => adapter.fetch(_capeCanaveralOffshore, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });

    test('Dio failure surfaces as SourceException', () async {
      final stub = _StubAdapter(
        dioError: DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.connectionError,
        ),
      );
      final dio = Dio()..httpClientAdapter = stub;
      final adapter = OpenTopoDataAdapter(http: dio);

      expect(
        () => adapter.fetch(_capeCanaveralOffshore, DateTime.now()),
        throwsA(isA<SourceException>()),
      );
    });
  });
}
