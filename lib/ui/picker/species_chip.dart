import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/engine_providers.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import 'species_picker_sheet.dart';

/// Pill-shaped chip at the top-left of the chart that displays the
/// currently selected species and opens the species picker on tap.
///
/// Reads [selectedSpeciesIdProvider] for the current id and
/// [availableSpeciesProvider] to resolve that id to a human label
/// (the species' first common name). Falls back to a humanized
/// version of the id while species data is still loading so the
/// chip never renders a flicker of empty text.
class SpeciesChip extends ConsumerWidget {
  const SpeciesChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speciesId = ref.watch(selectedSpeciesIdProvider);
    final speciesAsync = ref.watch(availableSpeciesProvider);
    final label = speciesAsync.maybeWhen(
      data: (records) {
        for (final r in records) {
          if (r.id == speciesId) {
            return r.commonNames.isNotEmpty
                ? r.commonNames.first
                : _humanize(speciesId);
          }
        }
        return _humanize(speciesId);
      },
      orElse: () => _humanize(speciesId),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => _open(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MarineSpacing.md + 2,
            vertical: MarineSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: MarineColors.surfaceElevated,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: MarineColors.divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: MarineTypography.label.copyWith(
                  color: MarineColors.onDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: MarineSpacing.xs),
              const Icon(
                Icons.expand_more,
                color: MarineColors.onDark,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _open(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SpeciesPickerSheet(),
    );
  }
}

/// Humanise a snake/kebab species id for the fallback label —
/// `common-snook` → `Common snook`. Used while species data is still
/// loading so the chip can render something stable.
String _humanize(String id) {
  if (id.isEmpty) return id;
  final spaced = id.replaceAll(RegExp(r'[-_]'), ' ');
  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}
