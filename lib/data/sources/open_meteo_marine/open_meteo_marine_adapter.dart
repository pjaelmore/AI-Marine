import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/types/condition_result.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'open_meteo_marine_parser.dart';

/// Open-Meteo Marine API adapter — global sea-surface temperature
/// fallback when no NDBC buoy with a `WTMP` reading is in range.
///
/// **Why model-derived SST is a second-tier source.** Open-Meteo's
/// Marine API ingests a blend of satellite and reanalysis data and
/// returns hourly SST on a coarse global grid. It's smoother than a
/// real buoy reading — small-scale features like Gulf Stream eddies
/// can be off by a couple of degrees — but it has the one property the
/// buoy network lacks: complete spatial coverage. Offshore tap points
/// 60+ nm from the nearest buoy now get a real number instead of "no
/// data."
///
/// **Confidence.** Model SST is reported at [_modelConfidence] (lower
/// than the buoy network's distance-based 0.5–1.0). The confidence
/// average across modifiers in [ReasoningBreakdown] will reflect that
/// the value is informative but not pinned.
///
/// **No auth.** Open-Meteo's hobbyist tier is free, no API key. The
/// terms-of-use ask for a referrer or User-Agent identifying the app —
/// the Dio setup already attaches one (TDD §5.8).
///
/// **Coverage / quotas.** Documented 10k requests/day per IP. The
/// four-tier cache absorbs heatmap re-renders to one network call per
/// rounded coordinate per hour, well inside the quota.
class OpenMeteoMarineAdapter extends SourceAdapter<double> {
  OpenMeteoMarineAdapter({required Dio http}) : _http = http;

  static const _baseUrl = 'https://marine-api.open-meteo.com/v1/marine';
  static const _modelConfidence = 0.7;

  final Dio _http;

  @override
  DataSource get sourceId => DataSource.openMeteoMarine;

  @override
  Duration get defaultTtl => const Duration(hours: 1);

  @override
  bool canServe(LatLng location, DateTime time) {
    // Coarse global-ocean envelope — the API itself rejects land
    // queries with an error response, but skipping obvious land here
    // (continental US latitudes outside the FL/Gulf/Atlantic span we
    // care about right now) saves a round-trip. v1 leaves the gate
    // permissive: the registry will fall through on a 4xx anyway.
    final lat = location.latitude;
    return lat >= -90 && lat <= 90;
  }

  @override
  Future<ConditionResult<double>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    final query = {
      'latitude': location.latitude.toStringAsFixed(4),
      'longitude': location.longitude.toStringAsFixed(4),
      'hourly': 'sea_surface_temperature',
      'timezone': 'UTC',
      // One day on either side of the query gives us the freshest
      // sample without paying for a multi-day window.
      'past_days': '1',
      'forecast_days': '2',
    };
    try {
      // Ask Dio for a `dynamic` payload — content-type-driven JSON
      // decoding sometimes hands back a raw String (the v1 routing
      // stubs do this; some CDNs do too with comma-separated content
      // types). We normalise both shapes ourselves, which is cheaper
      // than wrestling with Dio's transformer settings.
      final response = await _http.get<dynamic>(
        _baseUrl,
        queryParameters: query,
      );
      final raw = response.data;
      final Map<String, dynamic> body;
      if (raw is Map<String, dynamic>) {
        body = raw;
      } else if (raw is String && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is! Map<String, dynamic>) {
          throw const SourceException(
            'Open-Meteo Marine response root was not a JSON object',
            source: DataSource.openMeteoMarine,
          );
        }
        body = decoded;
      } else {
        throw const SourceException(
          'Open-Meteo Marine response was empty',
          source: DataSource.openMeteoMarine,
        );
      }
      final sample = parseOpenMeteoSeaSurfaceTemp(body, time.toUtc());
      final tempF = sample.tempC * 1.8 + 32;
      final fetchedAt = DateTime.now().toUtc();
      return ConditionResult<double>(
        value: tempF,
        unit: 'F',
        source: DataSource.openMeteoMarine,
        sourceDetails: const SourceDetails(),
        fetchedAt: fetchedAt,
        validUntil: fetchedAt.add(defaultTtl),
        confidence: _modelConfidence,
        observedAt: sample.observedAt,
      );
    } on DioException catch (e) {
      throw SourceException(
        'Open-Meteo Marine request failed',
        source: DataSource.openMeteoMarine,
        cause: e,
      );
    } on FormatException catch (e) {
      throw SourceException(
        'Open-Meteo Marine response was malformed',
        source: DataSource.openMeteoMarine,
        cause: e,
      );
    }
  }
}
