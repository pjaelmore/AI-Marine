import 'package:flutter/material.dart';

import '../../core/types/lat_lng.dart';
import '../../data/sources/osm/wreck_record.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'sheet_chrome.dart';

/// Bottom-sheet info card for a tapped OSM wreck. Header surfaces the
/// wreck name (or "Unnamed wreck (id)" fallback) plus distance from
/// the user's vessel; the body lists category and charted depth when
/// the upstream tags are populated.
///
/// All wreck data is static — pulled once from the bundled
/// `assets/osm_wrecks.json`. No live observation, no loading state,
/// no retry. Reuses [SheetChrome] so the surface stays in the same
/// family as the buoy and recommendation cards.
class WreckInfoSheet extends StatelessWidget {
  const WreckInfoSheet({
    super.key,
    required this.wreck,
    this.vesselPosition,
    this.onClose,
  });

  /// Wreck the user tapped.
  final WreckRecord wreck;

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
              wreck: wreck,
              vesselPosition: vesselPosition,
              onClose: onClose,
            ),
            const SizedBox(height: MarineSpacing.lg),
            _DetailGrid(wreck: wreck),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.wreck,
    required this.vesselPosition,
    required this.onClose,
  });

  final WreckRecord wreck;
  final LatLng? vesselPosition;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final title =
        wreck.name?.trim().isNotEmpty ?? false ? wreck.name! : 'Unnamed wreck';
    final subtitleParts = <String>[
      'OSM ${wreck.id}',
    ];
    if (vesselPosition != null) {
      final distance = wreck.distanceNmTo(vesselPosition!);
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
  const _DetailGrid({required this.wreck});

  final WreckRecord wreck;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailRow(
          label: 'Category',
          value: _formatCategory(wreck.category),
        ),
        _DetailRow(
          label: 'Depth',
          value: _formatDepth(wreck.depthM),
        ),
        _DetailRow(
          label: 'Position',
          value: _formatPosition(wreck.lat, wreck.lon),
        ),
        const SizedBox(height: MarineSpacing.sm),
        Text(
          'OSM data is community-contributed; verify against an '
          'official chart before navigating.',
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

/// `non-dangerous` → "Non-dangerous", etc. Hyphenated tag values get
/// the first letter uppercased so they read like prose. Unknown
/// values fall through unchanged. Returns "—" when no category is
/// tagged upstream.
String _formatCategory(String? raw) {
  if (raw == null || raw.isEmpty) return '—';
  final spaced = raw.replaceAll('_', ' ');
  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

/// Convert metres to feet for the US-fishing audience and append both.
String _formatDepth(double? m) {
  if (m == null) return '—';
  final ft = (m * 3.28084).toStringAsFixed(0);
  return '$ft ft (${m.toStringAsFixed(1)} m)';
}

String _formatPosition(double lat, double lon) {
  final latHem = lat >= 0 ? 'N' : 'S';
  final lonHem = lon >= 0 ? 'E' : 'W';
  return '${lat.abs().toStringAsFixed(4)}°$latHem, '
      '${lon.abs().toStringAsFixed(4)}°$lonHem';
}
