import 'package:ai_marine_engine/data/sources/ndbc/buoy_station.dart';
import 'package:ai_marine_engine/data/sources/ndbc/ndbc_adapter.dart';
import 'package:ai_marine_engine/state/component_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _NoopAdapter implements HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<dynamic>? cancelFuture,
  ) =>
      throw UnimplementedError('not used');
}

void main() {
  group('ndbcStationsProvider', () {
    test('returns the adapter\'s loaded stations', () async {
      final adapter =
          NdbcAdapter(http: Dio()..httpClientAdapter = _NoopAdapter())
            ..seedStationsForTesting([
              const BuoyStation(
                id: '42013',
                name: 'WFS Central Buoy',
                lat: 27.173,
                lon: -82.924,
              ),
              const BuoyStation(
                id: '41113',
                name: 'Cape Canaveral Nearshore',
                lat: 28.4,
                lon: -80.533,
              ),
            ]);

      final container = ProviderContainer(
        overrides: [
          ndbcAdapterProvider.overrideWith((ref) async => adapter),
        ],
      );
      addTearDown(container.dispose);

      final stations = await container.read(ndbcStationsProvider.future);
      expect(stations, hasLength(2));
      expect(stations.map((s) => s.id), containsAll(['42013', '41113']));
    });

    test('reflects an empty station list without error', () async {
      final adapter =
          NdbcAdapter(http: Dio()..httpClientAdapter = _NoopAdapter())
            ..seedStationsForTesting([]);

      final container = ProviderContainer(
        overrides: [
          ndbcAdapterProvider.overrideWith((ref) async => adapter),
        ],
      );
      addTearDown(container.dispose);

      final stations = await container.read(ndbcStationsProvider.future);
      expect(stations, isEmpty);
    });
  });
}
