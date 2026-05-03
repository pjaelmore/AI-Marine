import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../core/types/condition_result.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'buoy_observation.dart';
import 'buoy_station.dart';
import 'ndbc_parser.dart';

/// NDBC buoy adapter — TDD §5.2.
///
/// Resolves a query location to the nearest active station within a
/// configurable distance threshold (30 nm default per §5.2.4), fetches
/// the realtime2 feed, parses the latest observation row, and wraps it
/// in a [ConditionResult] with the spec'd 60-minute TTL.
class NdbcAdapter extends SourceAdapter<BuoyObservation> {
  NdbcAdapter({
    required Dio http,
    List<BuoyStation>? stations,
    double maxDistanceNm = 30,
  })  : _http = http,
        _stations = stations ?? const <BuoyStation>[],
        _maxDistanceNm = maxDistanceNm;

  /// Asset path for the bundled station list.
  static const String stationsAssetPath = 'assets/ndbc_stations.json';

  final Dio _http;
  List<BuoyStation> _stations;
  final double _maxDistanceNm;

  /// Loads the station list from the bundled asset — call once at startup
  /// before [canServe] is queried. v1 ships ~6 stations covering MA/RI/CT/NY
  /// waters; updates land via app releases.
  Future<void> loadStations() async {
    final raw = await rootBundle.loadString(stationsAssetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = (json['stations'] as List).cast<Map<String, dynamic>>();
    _stations = list.map(BuoyStation.fromJson).toList();
  }

  /// Test seam — bypasses the asset bundle.
  void seedStationsForTesting(List<BuoyStation> stations) {
    _stations = stations;
  }

  @override
  DataSource get sourceId => DataSource.noaaNdbc;

  @override
  Duration get defaultTtl => const Duration(minutes: 60);

  @override
  bool canServe(LatLng location, DateTime time) {
    return _findNearestStation(location) != null;
  }

  @override
  Future<ConditionResult<BuoyObservation>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    final station = _findNearestStation(location);
    if (station == null) {
      throw const SourceException(
        'no NDBC station within range',
        source: DataSource.noaaNdbc,
      );
    }
    final url = 'https://www.ndbc.noaa.gov/data/realtime2/${station.id}.txt';
    try {
      final response = await _http.get<String>(url);
      final body = response.data;
      if (body == null || body.isEmpty) {
        throw const SourceException(
          'NDBC response was empty',
          source: DataSource.noaaNdbc,
        );
      }
      final observation = parseLatestNdbc(body, station.id);
      final fetchedAt = DateTime.now().toUtc();
      return ConditionResult<BuoyObservation>(
        value: observation,
        unit: 'composite',
        source: DataSource.noaaNdbc,
        sourceDetails: SourceDetails(
          stationId: station.id,
          interpolationDistanceNm: station.distanceNmTo(location),
        ),
        fetchedAt: fetchedAt,
        validUntil: fetchedAt.add(defaultTtl),
        confidence: _confidenceFromDistance(station.distanceNmTo(location)),
      );
    } on DioException catch (e) {
      throw SourceException(
        'NDBC request to ${station.id} failed',
        source: DataSource.noaaNdbc,
        cause: e,
      );
    } on FormatException catch (e) {
      throw SourceException(
        'NDBC response from ${station.id} was malformed',
        source: DataSource.noaaNdbc,
        cause: e,
      );
    }
  }

  BuoyStation? _findNearestStation(LatLng location) {
    BuoyStation? best;
    var bestDistance = _maxDistanceNm;
    for (final station in _stations) {
      final d = station.distanceNmTo(location);
      if (d <= bestDistance) {
        best = station;
        bestDistance = d;
      }
    }
    return best;
  }
}

/// Linear confidence falloff across the 30 nm acceptance radius:
/// 1.0 at the station, 0.5 at the threshold. Keeps the engine from
/// trusting a far-away buoy as much as a nearby one.
double _confidenceFromDistance(double distanceNm) {
  const halfPoint = 30.0;
  final scaled = 1.0 - (distanceNm / (halfPoint * 2));
  return scaled.clamp(0.0, 1.0);
}
