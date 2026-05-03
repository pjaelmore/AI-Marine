import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import '../../../core/types/condition_result.dart';
import '../../../core/types/conditions.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'tide_phase_computer.dart';
import 'tide_prediction.dart';
import 'tide_station.dart';
import 'tides_currents_parser.dart';

/// NOAA Tides & Currents adapter — TDD §5.3.
///
/// Picks the nearest bundled station within 60 nm, fetches high/low
/// predictions for ±1 day around the query time, and uses
/// [computeTideStateAt] to derive the phase / amplitude / time-to-next.
/// 60 nm threshold (vs NDBC's 30) reflects that tide phase is more
/// spatially coherent than buoy observations: same harbor entrance
/// behaves similarly across tens of miles.
class TidesAndCurrentsAdapter extends SourceAdapter<TideState> {
  TidesAndCurrentsAdapter({
    required Dio http,
    List<TideStation>? stations,
    double maxDistanceNm = 60,
  })  : _http = http,
        _stations = stations ?? const <TideStation>[],
        _maxDistanceNm = maxDistanceNm;

  static const String stationsAssetPath = 'assets/tide_stations.json';
  static const _endpoint =
      'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter';
  static final _yyyymmdd = DateFormat('yyyyMMdd');

  final Dio _http;
  List<TideStation> _stations;
  final double _maxDistanceNm;

  Future<void> loadStations() async {
    final raw = await rootBundle.loadString(stationsAssetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = (json['stations'] as List).cast<Map<String, dynamic>>();
    _stations = list.map(TideStation.fromJson).toList();
  }

  void seedStationsForTesting(List<TideStation> stations) {
    _stations = stations;
  }

  @override
  DataSource get sourceId => DataSource.noaaTidesAndCurrents;

  @override
  Duration get defaultTtl => const Duration(minutes: 15);

  @override
  bool canServe(LatLng location, DateTime time) {
    return findNearestStation(location) != null;
  }

  @override
  Future<ConditionResult<TideState>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    final station = findNearestStation(location);
    if (station == null) {
      throw const SourceException(
        'no Tides & Currents station within range',
        source: DataSource.noaaTidesAndCurrents,
      );
    }
    final predictions = await fetchPredictions(station: station, time: time);
    final tide = computeTideStateAt(time.toUtc(), predictions);
    final fetchedAt = DateTime.now().toUtc();
    return ConditionResult<TideState>(
      value: tide,
      unit: 'phase',
      source: DataSource.noaaTidesAndCurrents,
      sourceDetails: SourceDetails(
        stationId: station.id,
        interpolationDistanceNm: station.distanceNmTo(location),
      ),
      fetchedAt: fetchedAt,
      validUntil: fetchedAt.add(defaultTtl),
      confidence: confidenceFromDistance(station.distanceNmTo(location)),
    );
  }

  /// Fetches the raw predictions list for [station] over a ±1 day
  /// window around [time]. The list is what the cold tier caches
  /// (one row per station+dayBucket); phase computation is local
  /// and runs on every lookup. Throws [SourceException] on network
  /// or parse failure so callers can match the existing pattern.
  Future<List<TidePrediction>> fetchPredictions({
    required TideStation station,
    required DateTime time,
  }) async {
    final timeUtc = time.toUtc();
    final beginDate = _yyyymmdd.format(
      timeUtc.subtract(const Duration(days: 1)),
    );
    final endDate = _yyyymmdd.format(
      timeUtc.add(const Duration(days: 1)),
    );
    try {
      final response = await _http.get<String>(
        _endpoint,
        queryParameters: {
          'product': 'predictions',
          'station': station.id,
          'begin_date': beginDate,
          'end_date': endDate,
          'datum': 'MLLW',
          'time_zone': 'GMT',
          'units': 'english',
          'interval': 'hilo',
          'format': 'json',
          'application': 'AIMarineRecommendation',
        },
      );
      final body = response.data;
      if (body == null || body.isEmpty) {
        throw const SourceException(
          'Tides & Currents response was empty',
          source: DataSource.noaaTidesAndCurrents,
        );
      }
      final predictions = parseTidePredictions(body);
      if (predictions.isEmpty) {
        throw const SourceException(
          'Tides & Currents returned zero predictions',
          source: DataSource.noaaTidesAndCurrents,
        );
      }
      return predictions;
    } on DioException catch (e) {
      throw SourceException(
        'Tides & Currents request to ${station.id} failed',
        source: DataSource.noaaTidesAndCurrents,
        cause: e,
      );
    } on FormatException catch (e) {
      throw SourceException(
        'Tides & Currents response from ${station.id} was malformed',
        source: DataSource.noaaTidesAndCurrents,
        cause: e,
      );
    }
  }

  /// Nearest seeded station within [_maxDistanceNm], or null. Public
  /// so the cached path in ConditionsServiceImpl can resolve the
  /// station before consulting the cold tier.
  TideStation? findNearestStation(LatLng location) {
    TideStation? best;
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

/// Linear confidence falloff across the 60 nm threshold: 1.0 at the
/// station, 0.5 at the edge. Top-level so the cached path in
/// ConditionsServiceImpl uses the same formula as the all-in-one
/// fetch().
double confidenceFromDistance(double distanceNm) {
  const halfPoint = 60.0;
  final scaled = 1.0 - (distanceNm / (halfPoint * 2));
  return scaled.clamp(0.0, 1.0);
}
