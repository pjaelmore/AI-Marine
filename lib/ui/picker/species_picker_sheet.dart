import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/species/models/species_record.dart';
import '../../state/engine_providers.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';
import '../recommendation/sheet_chrome.dart';

/// Modal bottom sheet listing every loaded species with the
/// currently selected one highlighted. Tapping a row writes
/// [selectedSpeciesIdProvider] and dismisses the sheet — every
/// downstream provider keyed by species (score, eventual heatmap)
/// reacts automatically.
///
/// Reuses [SheetChrome] so the picker reads as part of the same
/// recommendation surface family the user already knows.
class SpeciesPickerSheet extends ConsumerWidget {
  const SpeciesPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedSpeciesIdProvider);
    final speciesAsync = ref.watch(availableSpeciesProvider);

    return SafeArea(
      top: false,
      child: SheetChrome(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: speciesAsync.when(
            loading: () => const _LoadingBody(),
            error: (e, _) => _ErrorBody(error: e.toString()),
            data: (records) => _PickerBody(
              records: records,
              selectedId: selectedId,
              onSelect: (id) {
                ref.read(selectedSpeciesIdProvider.notifier).state = id;
                Navigator.of(context).maybePop();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarineSpacing.xl,
        vertical: MarineSpacing.lg,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                MarineColors.actionTeal,
              ),
            ),
          ),
          SizedBox(width: MarineSpacing.md),
          Text('Loading species…'),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Text(
            "Couldn't load species",
            style: MarineTypography.headingSmall.copyWith(
              color: MarineColors.onDark,
            ),
          ),
          const SizedBox(height: MarineSpacing.xs),
          Text(
            error,
            style: MarineTypography.bodyMedium.copyWith(
              color: MarineColors.onDark.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerBody extends StatelessWidget {
  const _PickerBody({
    required this.records,
    required this.selectedId,
    required this.onSelect,
  });

  final List<SpeciesRecord> records;
  final String selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            MarineSpacing.xl,
            0,
            MarineSpacing.xl,
            MarineSpacing.sm,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'TARGET SPECIES',
              style: MarineTypography.label.copyWith(
                color: MarineColors.onDark.withAlpha(160),
                letterSpacing: 0.8,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: records.length,
            padding: const EdgeInsets.only(bottom: MarineSpacing.md),
            itemBuilder: (_, i) {
              final r = records[i];
              return _SpeciesRow(
                record: r,
                selected: r.id == selectedId,
                onTap: () => onSelect(r.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SpeciesRow extends StatelessWidget {
  const _SpeciesRow({
    required this.record,
    required this.selected,
    required this.onTap,
  });

  final SpeciesRecord record;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final commonName =
        record.commonNames.isNotEmpty ? record.commonNames.first : record.id;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MarineSpacing.xl,
          vertical: MarineSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commonName,
                    style: MarineTypography.bodyLarge.copyWith(
                      color: MarineColors.onDark,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  if (record.scientificName.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        record.scientificName,
                        style: MarineTypography.bodySmall.copyWith(
                          color: MarineColors.onDark.withAlpha(150),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check,
                color: MarineColors.actionTeal,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
