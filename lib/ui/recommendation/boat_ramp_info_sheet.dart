import 'package:flutter/material.dart';

import '../../core/types/lat_lng.dart';
import '../../data/sources/osm/boat_ramp_record.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'sheet_chrome.dart';

/// Bottom-sheet info card for a tapped OSM boat ramp. Header surfaces
/// the ramp name (or "Unnamed boat ramp" fallback) plus distance from
/// the user's vessel; the body lists access, fee, and surface where
/// the upstream tags are populated.
///
/// All ramp data is static — pulled once from the bundled
/// `assets/osm_ramps.json`. No live observation, no loading state.
/// Slice 13a will add a "Plan a trip from here" action that uses the
/// ramp as the trip-area anchor.
class BoatRampInfoSheet extends StatelessWidget {
  const BoatRampInfoSheet({
    super.key,
    required this.ramp,
    this.vesselPosition,
    this.onClose,
  });

  /// Ramp the user tapped.
  final BoatRampRecord ramp;

  /// Optional vessel position used to render a distance line. Hidden
  /// when null (no GPS fix yet).
  final LatLng? vesselPosition;

  /// Optional dismiss callback wired by the chart shell.
  final VoidCallback? onClose;

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
              ramp: ramp,
              vesselPosition: vesselPosition,
              onClose: onClose,
            ),
            const SizedBox(height: MarineSpacing.lg),
            _DetailGrid(ramp: ramp),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.ramp,
    required this.vesselPosition,
    required this.onClose,
  });

  final BoatRampRecord ramp;
  final LatLng? vesselPosition;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final title = ramp.name?.trim().isNotEmpty ?? false
        ? ramp.name!
        : 'Unnamed boat ramp';
    final subtitleParts = <String>['OSM ${ramp.id}'];
    if (vesselPosition != null) {
      final distance = ramp.distanceNmTo(vesselPosition!);
      subtitleParts.add('${distance.toStringAsFixed(1)} nm from vessel');
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: MarineTypography.headingSmall.copyWith(
                  color: MarineColors.onDark,
                ),
              ),
              const SizedBox(height: 2),
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

class _DetailGrid extends StatelessWidget {
  const _DetailGrid({required this.ramp});

  final BoatRampRecord ramp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailRow(label: 'Access', value: _formatAccess(ramp.access)),
        _DetailRow(label: 'Fee', value: _formatFee(ramp.fee)),
        _DetailRow(label: 'Surface', value: _formatSurface(ramp.surface)),
        _DetailRow(
          label: 'Position',
          value: _formatPosition(ramp.lat, ramp.lon),
        ),
        const SizedBox(height: MarineSpacing.sm),
        Text(
          'OSM data is community-contributed; verify hours and fees '
          'before launch.',
          style: MarineTypography.bodySmall.copyWith(
            color: MarineColors.onDark.withAlpha(140),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

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

/// `yes` → "Public", `permissive` → "Permissive", `customers` →
/// "Customers only", `permit` → "Permit required". Unknown values
/// fall through capitalised. Missing tag → "—".
String _formatAccess(String? raw) {
  if (raw == null || raw.isEmpty) return '—';
  switch (raw) {
    case 'yes':
      return 'Public';
    case 'permissive':
      return 'Permissive';
    case 'customers':
      return 'Customers only';
    case 'permit':
      return 'Permit required';
    default:
      return '${raw[0].toUpperCase()}${raw.substring(1)}';
  }
}

String _formatFee(String? raw) {
  if (raw == null || raw.isEmpty) return '—';
  switch (raw) {
    case 'yes':
      return 'Yes — fee charged';
    case 'no':
      return 'No fee';
    default:
      return '${raw[0].toUpperCase()}${raw.substring(1)}';
  }
}

String _formatSurface(String? raw) {
  if (raw == null || raw.isEmpty) return '—';
  return '${raw[0].toUpperCase()}${raw.substring(1)}';
}

String _formatPosition(double lat, double lon) {
  final latHem = lat >= 0 ? 'N' : 'S';
  final lonHem = lon >= 0 ? 'E' : 'W';
  return '${lat.abs().toStringAsFixed(4)}°$latHem, '
      '${lon.abs().toStringAsFixed(4)}°$lonHem';
}
