import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/types/lat_lng.dart';
import '../../data/sources/ndbc/buoy_observation.dart';
import '../../data/sources/ndbc/buoy_station.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'sheet_chrome.dart';

/// Bottom-sheet info card for a tapped NDBC buoy. Header surfaces the
/// station name, id, and distance from the user's vessel; the body
/// renders the latest live observation pulled via
/// [stationObservationProvider] — wind, water/air temp, waves,
/// pressure. Each row falls back to a muted em-dash when the underlying
/// field is absent (NDBC's "MM" missing-value sentinel).
///
/// Distinct from [RecommendationCardSheet]: this is diagnostic ("what
/// is this buoy reporting right now") rather than prescriptive ("where
/// should I fish"). Reuses [SheetChrome] so the surface is recognizably
/// part of the same family.
class StationInfoSheet extends StatelessWidget {
  const StationInfoSheet({
    super.key,
    required this.station,
    required this.observation,
    required this.fetchedAt,
    this.vesselPosition,
    this.onClose,
  });

  /// Station the user tapped.
  final BuoyStation station;

  /// Latest parsed observation. Individual fields may be null when
  /// the buoy didn't report that sensor on the latest row.
  final BuoyObservation observation;

  /// Wall-clock time the data was fetched. Drives the "last updated"
  /// caption.
  final DateTime fetchedAt;

  /// Optional vessel position used to render a distance line. Hidden
  /// when null (no GPS fix yet).
  final LatLng? vesselPosition;

  /// Optional dismiss callback wired by the chart shell.
  final VoidCallback? onClose;

  static final _timeFormatter = DateFormat('h:mm a');

  @override
  Widget build(BuildContext context) {
    return SheetChrome(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          MarineSpacing.xl,
          MarineSpacing.md,
          MarineSpacing.xl,
          MarineSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _Header(
              station: station,
              vesselPosition: vesselPosition,
              fetchedAt: fetchedAt,
              onClose: onClose,
              timeFormatter: _timeFormatter,
            ),
            const SizedBox(height: MarineSpacing.lg),
            _ObservationGrid(observation: observation),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.station,
    required this.vesselPosition,
    required this.fetchedAt,
    required this.onClose,
    required this.timeFormatter,
  });

  final BuoyStation station;
  final LatLng? vesselPosition;
  final DateTime fetchedAt;
  final VoidCallback? onClose;
  final DateFormat timeFormatter;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = <String>[];
    if (vesselPosition != null) {
      final distance = station.distanceNmTo(vesselPosition!);
      subtitleParts.add('${distance.toStringAsFixed(1)} nm from vessel');
    }
    subtitleParts.add('Updated ${timeFormatter.format(fetchedAt.toLocal())}');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                station.name,
                style: MarineTypography.headingSmall.copyWith(
                  color: MarineColors.onDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'NDBC ${station.id}',
                style: MarineTypography.bodySmall.copyWith(
                  color: MarineColors.onDark.withAlpha(150),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: MarineSpacing.xs),
              Text(
                subtitleParts.join(' · '),
                style: MarineTypography.bodySmall.copyWith(
                  color: MarineColors.onDark.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
        if (onClose != null)
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: onClose,
            tooltip: 'Dismiss',
          ),
      ],
    );
  }
}

class _ObservationGrid extends StatelessWidget {
  const _ObservationGrid({required this.observation});

  final BuoyObservation observation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ObservationRow(
          label: 'Wind',
          value: _formatWind(observation),
        ),
        _ObservationRow(
          label: 'Water temp',
          value: _formatWaterTemp(observation.waterTempC),
        ),
        _ObservationRow(
          label: 'Air temp',
          value: _formatAirTemp(observation.airTempC),
        ),
        _ObservationRow(
          label: 'Waves',
          value: _formatWaves(observation),
        ),
        _ObservationRow(
          label: 'Pressure',
          value: _formatPressure(observation.pressureHpa),
        ),
      ],
    );
  }
}

class _ObservationRow extends StatelessWidget {
  const _ObservationRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final missing = value == '—';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MarineSpacing.xs + 2),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: MarineTypography.bodySmall.copyWith(
                color: MarineColors.onDark.withAlpha(150),
                letterSpacing: 0.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: MarineTypography.bodyMedium.copyWith(
                color: missing
                    ? MarineColors.onDark.withAlpha(120)
                    : MarineColors.onDark,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Convert m/s wind speed to mph and append direction. Returns "—"
/// when the sensor didn't report on the latest row.
String _formatWind(BuoyObservation o) {
  final speed = o.windSpeedMps;
  if (speed == null) return '—';
  final mph = (speed * 2.23694).round();
  final dir = _compassFromDegrees(o.windDirDegT);
  final gust = o.gustMps;
  final gustStr = gust != null ? ' (gusts ${(gust * 2.23694).round()})' : '';
  if (dir != null) return '$mph mph from $dir$gustStr';
  return '$mph mph$gustStr';
}

String _formatWaterTemp(double? c) {
  if (c == null) return '—';
  final f = (c * 9 / 5 + 32).round();
  return '$f°F (${c.toStringAsFixed(1)}°C)';
}

String _formatAirTemp(double? c) {
  if (c == null) return '—';
  final f = (c * 9 / 5 + 32).round();
  return '$f°F (${c.toStringAsFixed(1)}°C)';
}

String _formatWaves(BuoyObservation o) {
  final h = o.waveHeightM;
  if (h == null) return '—';
  final ft = (h * 3.28084).toStringAsFixed(1);
  final period = o.dominantPeriodSec;
  if (period != null) {
    return '$ft ft @ ${period.toStringAsFixed(0)}s';
  }
  return '$ft ft';
}

String _formatPressure(double? hpa) {
  if (hpa == null) return '—';
  return '${hpa.toStringAsFixed(1)} hPa';
}

/// Convert a true-north heading in degrees to a compass abbreviation
/// (N, NNE, NE, …). Returns null when [degrees] is null.
String? _compassFromDegrees(double? degrees) {
  if (degrees == null) return null;
  const labels = [
    'N',
    'NNE',
    'NE',
    'ENE',
    'E',
    'ESE',
    'SE',
    'SSE',
    'S',
    'SSW',
    'SW',
    'WSW',
    'W',
    'WNW',
    'NW',
    'NNW',
  ];
  final idx = (((degrees % 360) / 22.5) + 0.5).floor() % 16;
  return labels[idx];
}
