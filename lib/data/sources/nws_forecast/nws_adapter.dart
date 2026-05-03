import 'package:dio/dio.dart';

import '../../../core/types/condition_result.dart';
import '../../../core/types/conditions.dart';
import '../../../core/types/lat_lng.dart';
import '../source_adapter.dart';
import 'forecast_period.dart';
import 'nws_parser.dart';
import 'wind_string_parser.dart';

/// NWS marine forecast adapter — TDD §5.4.
///
/// Two-step lookup: resolve `(lat, lon)` to a forecast URL via
/// `/points/{lat},{lon}`, then fetch periods from that URL. Step 1 results
/// are cached in-memory keyed by rounded coordinates; the spec calls for
/// a 30-day cache (§5.4.4) but Phase 3 keeps it ephemeral until Phase 4's
/// CacheManager wires through the conditions_cache table.
///
/// Returns the [WindVector] for the forecast period whose interval
/// contains the query time, or the closest available period if none
/// contain it (typical when the query is "right now" but the forecast
/// snapshot hasn't yet rolled).
class NwsAdapter extends SourceAdapter<WindVector> {
  NwsAdapter({required Dio http}) : _http = http;

  static const _baseUrl = 'https://api.weather.gov';

  final Dio _http;

  /// In-memory zone-URL cache. Key is rounded "lat,lon" (4 decimal places ≈
  /// 11 m). v1 keeps it ephemeral; Phase 4 promotes to conditions_cache.
  final Map<String, String> _zoneCache = <String, String>{};

  @override
  DataSource get sourceId => DataSource.noaaMarineForecast;

  @override
  Duration get defaultTtl => const Duration(hours: 6);

  @override
  bool canServe(LatLng location, DateTime time) {
    // NWS covers continental US, AK, HI, PR. Coarse bounding box rejects
    // queries outside that range without paying for a network round-trip.
    final lat = location.latitude;
    final lon = location.longitude;
    if (lat < 18 || lat > 72) return false;
    if (lon < -180 || lon > -65) return false;
    return true;
  }

  @override
  Future<ConditionResult<WindVector>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    final forecastUrl = await _resolveForecastUrl(location);
    final periods = await _fetchPeriods(forecastUrl);
    if (periods.isEmpty) {
      throw const SourceException(
        'NWS forecast returned no periods',
        source: DataSource.noaaMarineForecast,
      );
    }
    final period = _bestPeriodFor(time, periods);
    final wind = parseNwsWind(period.windSpeedRaw, period.windDirectionRaw);
    if (wind == null) {
      // Calm or unparseable wind; surface as unavailable rather than zero.
      throw SourceException(
        'NWS reported a wind value the parser cannot interpret '
        '("${period.windSpeedRaw}"); treating as unavailable',
        source: DataSource.noaaMarineForecast,
      );
    }
    final fetchedAt = DateTime.now().toUtc();
    return ConditionResult<WindVector>(
      value: wind,
      unit: 'kt',
      source: DataSource.noaaMarineForecast,
      sourceDetails: SourceDetails(noaaZoneId: forecastUrl),
      fetchedAt: fetchedAt,
      validUntil: fetchedAt.add(defaultTtl),
      // NWS forecasts are point-resolved (not interpolated from sparse
      // stations); same confidence regardless of distance.
      confidence: 0.9,
    );
  }

  Future<String> _resolveForecastUrl(LatLng location) async {
    final key = _coordKey(location);
    final cached = _zoneCache[key];
    if (cached != null) return cached;

    final pointsUrl =
        '$_baseUrl/points/${location.latitude},${location.longitude}';
    try {
      final response = await _http.get<String>(
        pointsUrl,
        options: Options(headers: {'Accept': 'application/geo+json'}),
      );
      final body = response.data;
      if (body == null || body.isEmpty) {
        throw const SourceException(
          'NWS points response was empty',
          source: DataSource.noaaMarineForecast,
        );
      }
      final url = parseForecastUrl(body);
      _zoneCache[key] = url;
      return url;
    } on DioException catch (e) {
      throw SourceException(
        'NWS points lookup for ${location.latitude},${location.longitude} failed',
        source: DataSource.noaaMarineForecast,
        cause: e,
      );
    } on FormatException catch (e) {
      throw SourceException(
        'NWS points response was malformed',
        source: DataSource.noaaMarineForecast,
        cause: e,
      );
    }
  }

  Future<List<ForecastPeriod>> _fetchPeriods(String forecastUrl) async {
    try {
      final response = await _http.get<String>(forecastUrl);
      final body = response.data;
      if (body == null || body.isEmpty) {
        throw const SourceException(
          'NWS forecast response was empty',
          source: DataSource.noaaMarineForecast,
        );
      }
      return parseForecastPeriods(body);
    } on DioException catch (e) {
      throw SourceException(
        'NWS forecast fetch failed',
        source: DataSource.noaaMarineForecast,
        cause: e,
      );
    } on FormatException catch (e) {
      throw SourceException(
        'NWS forecast response was malformed',
        source: DataSource.noaaMarineForecast,
        cause: e,
      );
    }
  }

  /// Picks the forecast period covering [time], or the closest period by
  /// midpoint distance if none contain it. Exposed for direct testing.
  ForecastPeriod _bestPeriodFor(DateTime time, List<ForecastPeriod> periods) {
    final t = time.toUtc();
    for (final p in periods) {
      if (!t.isBefore(p.startTime) && t.isBefore(p.endTime)) return p;
    }
    var best = periods.first;
    var bestDist = _midpointDistance(best, t).abs();
    for (final p in periods.skip(1)) {
      final d = _midpointDistance(p, t).abs();
      if (d < bestDist) {
        best = p;
        bestDist = d;
      }
    }
    return best;
  }

  static int _midpointDistance(ForecastPeriod p, DateTime t) {
    final mid = p.startTime.add(p.endTime.difference(p.startTime) ~/ 2);
    return mid.difference(t).inMinutes;
  }

  /// Rounded coordinate key for the zone-URL cache. 4 decimals ≈ 11 m,
  /// well below NWS's grid resolution (~2.5 km).
  String _coordKey(LatLng location) {
    final lat = (location.latitude * 10000).round() / 10000;
    final lon = (location.longitude * 10000).round() / 10000;
    return '$lat,$lon';
  }
}
