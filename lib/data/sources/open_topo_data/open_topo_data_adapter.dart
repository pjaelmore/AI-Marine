import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/types/condition_result.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'open_topo_data_parser.dart';

/// OpenTopoData GEBCO bathymetry adapter — global ocean depth lookup
/// when no chart-based bathymetry is loaded.
///
/// GEBCO 2020 is the standard global bathymetry compilation (NOAA,
/// USACE, NIWA, etc. consolidated into a single ~450 m grid). It
/// closes the biggest data gap in the Phase 6 score model: without a
/// real depth value, the depth modifier returns `unavailable` for
/// every cell, so an inshore tap for a bluewater species can't be
/// penalised on water depth alone — the migration gate has to catch it.
///
/// **Confidence.** Bathymetry is essentially static, but the value at
/// any point is the cell mean over a ~450 m square — locally rough or
/// hard-bottomed spots are smoothed. Reported at [_modelConfidence]
/// (matching Open-Meteo SST) so the breakdown's aggregate confidence
/// reflects the model-derived nature.
///
/// **Static data, long defaultTtl.** Bathymetry doesn't change in any
/// fishing-relevant way at this resolution; the [defaultTtl] is one
/// day so the cache layer is happy keeping the value warm across
/// repeated heatmap renders.
///
/// **No auth.** OpenTopoData's hobbyist tier is free, no key. Rate
/// limit is 1000 requests/day per IP; the four-tier cache absorbs
/// duplicates so a typical bbox at heatmap resolution uses well under
/// 100 requests per render.
class OpenTopoDataAdapter extends SourceAdapter<double> {
  OpenTopoDataAdapter({required Dio http}) : _http = http;

  static const _baseUrl = 'https://api.opentopodata.org/v1/gebco2020';
  static const _modelConfidence = 0.7;

  final Dio _http;

  @override
  DataSource get sourceId => DataSource.openTopoData;

  @override
  Duration get defaultTtl => const Duration(days: 1);

  @override
  bool canServe(LatLng location, DateTime time) {
    final lat = location.latitude;
    return lat >= -90 && lat <= 90;
  }

  @override
  Future<ConditionResult<double>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    final loc = '${location.latitude.toStringAsFixed(4)},'
        '${location.longitude.toStringAsFixed(4)}';
    try {
      final response = await _http.get<dynamic>(
        _baseUrl,
        queryParameters: {'locations': loc},
      );
      final raw = response.data;
      final Map<String, dynamic> body;
      if (raw is Map<String, dynamic>) {
        body = raw;
      } else if (raw is String && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is! Map<String, dynamic>) {
          throw const SourceException(
            'OpenTopoData response root was not a JSON object',
            source: DataSource.openTopoData,
          );
        }
        body = decoded;
      } else {
        throw const SourceException(
          'OpenTopoData response was empty',
          source: DataSource.openTopoData,
        );
      }
      final sample = parseOpenTopoDataDepth(body);
      if (sample.isLand) {
        // Land or above-water query — surface as a source failure so
        // the registry / service falls through to "unavailable" rather
        // than handing the calculator a misleading zero. The depth
        // modifier should never fire on land taps.
        throw const SourceException(
          'OpenTopoData reports above-water elevation at this location',
          source: DataSource.openTopoData,
        );
      }
      final fetchedAt = DateTime.now().toUtc();
      return ConditionResult<double>(
        value: sample.depthFt,
        unit: 'ft',
        source: DataSource.openTopoData,
        sourceDetails: const SourceDetails(),
        fetchedAt: fetchedAt,
        validUntil: fetchedAt.add(defaultTtl),
        confidence: _modelConfidence,
        // GEBCO is a static compilation; "observation time" is meaningless
        // here, so leave observedAt null — the card will skip the
        // freshness subtitle.
      );
    } on DioException catch (e) {
      throw SourceException(
        'OpenTopoData request failed',
        source: DataSource.openTopoData,
        cause: e,
      );
    } on FormatException catch (e) {
      throw SourceException(
        'OpenTopoData response was malformed',
        source: DataSource.openTopoData,
        cause: e,
      );
    }
  }
}
