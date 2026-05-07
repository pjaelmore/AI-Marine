import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/types/lat_lng.dart';
import '../../core/types/trip_plan.dart';
import '../../data/sources/osm/boat_ramp_record.dart';
import '../../state/engine_providers.dart';
import '../../state/osm_ramps_provider.dart';
import '../../state/plan_trip_draft_provider.dart';
import '../../state/trip_providers.dart';
import '../../state/vessel_providers.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// Default trip-area radius around the picked ramp, in nautical
/// miles. Covers most inshore + nearshore offshore fishing; bbox
/// dragging to expand for offshore runs lands in 13a.3.
const _defaultTripRadiusNm = 15.0;

/// 4-step "Plan a trip" wizard. Custom layout instead of Material's
/// Stepper because the latter renders invisibly on the marine dark
/// theme — the controls + circles use light-mode colours that get
/// lost against `surface = deepMarine`. We render a header strip
/// showing step n/4 + title, the current step body, and a fixed
/// bottom bar with Back / Continue (or Save) buttons.
class PlanTripScreen extends ConsumerStatefulWidget {
  const PlanTripScreen({super.key});

  @override
  ConsumerState<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends ConsumerState<PlanTripScreen> {
  int _step = 0;
  bool _saving = false;

  static const _stepTitles = [
    'Boat ramp',
    'Time window',
    'Target species',
    'Review',
  ];

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(planTripDraftProvider);
    final isLast = _step == _stepTitles.length - 1;
    return Scaffold(
      backgroundColor: MarineColors.deepMarine,
      appBar: AppBar(
        // Slightly elevated so the AppBar is visible against the
        // deepMarine scaffold background.
        backgroundColor: MarineColors.surfaceElevated,
        foregroundColor: MarineColors.onDark,
        title: const Text('Plan a trip'),
      ),
      body: Column(
        children: [
          _StepHeader(
            step: _step,
            total: _stepTitles.length,
            titles: _stepTitles,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(MarineSpacing.lg),
              child: switch (_step) {
                0 => _RampStep(
                    selected: draft.ramp,
                    onPick: (r) {
                      ref.read(planTripDraftProvider.notifier).setRamp(r);
                      setState(() => _step = 1);
                    },
                  ),
                1 => _TimeStep(
                    start: draft.plannedStart,
                    end: draft.plannedEnd,
                    onChange: (s, e) {
                      ref
                          .read(planTripDraftProvider.notifier)
                          .setTimeWindow(s, e);
                    },
                  ),
                2 => _SpeciesStep(
                    selectedId: draft.targetSpeciesId,
                    onPick: (id) =>
                        ref.read(planTripDraftProvider.notifier).setSpecies(id),
                  ),
                _ => _ReviewStep(draft: draft),
              },
            ),
          ),
          _BottomBar(
            isLast: isLast,
            canContinue: _canAdvanceTo(_step + 1, draft),
            canSave: draft.isComplete && !_saving,
            saving: _saving,
            showBack: _step > 0,
            onBack: () => setState(() => _step = (_step - 1).clamp(0, 3)),
            onContinue: () => setState(() => _step = (_step + 1).clamp(0, 3)),
            onSave: _save,
          ),
        ],
      ),
    );
  }

  bool _canAdvanceTo(int target, PlanTripDraft draft) {
    if (target <= 0) return true;
    if (target >= 1 && draft.ramp == null) return false;
    if (target >= 2 &&
        (draft.plannedStart == null || draft.plannedEnd == null)) {
      return false;
    }
    if (target >= 3 &&
        (draft.targetSpeciesId == null || draft.targetSpeciesId!.isEmpty)) {
      return false;
    }
    return true;
  }

  Future<void> _save() async {
    final draft = ref.read(planTripDraftProvider);
    if (!draft.isComplete) return;
    setState(() => _saving = true);
    try {
      final ramp = draft.ramp!;
      final bounds = LatLngBounds.fromCenter(
        center: ramp.location,
        radiusNm: _defaultTripRadiusNm,
      );
      final plan = TripPlan(
        id: 'trip-${DateTime.now().toUtc().millisecondsSinceEpoch}',
        name: draft.name?.trim().isNotEmpty ?? false
            ? draft.name!
            : _autoName(draft, ramp),
        bounds: bounds,
        plannedStart: draft.plannedStart!.toUtc(),
        plannedEnd: draft.plannedEnd!.toUtc(),
        targetSpeciesId: draft.targetSpeciesId!,
        createdAt: DateTime.now().toUtc(),
        cacheStatus: TripCacheStatus(rampId: ramp.id),
      );
      await ref.read(tripPlansRepositoryProvider).save(plan);
      ref.read(activeTripIdProvider.notifier).state = plan.id;
      ref.invalidate(savedTripsProvider);
      ref.read(planTripDraftProvider.notifier).reset();
      if (mounted) Navigator.of(context).pop(plan.id);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _autoName(PlanTripDraft draft, BoatRampRecord ramp) {
    final rampLabel =
        ramp.name?.trim().isNotEmpty ?? false ? ramp.name! : 'Ramp ${ramp.id}';
    final dateFmt = DateFormat('MMM d');
    final start = draft.plannedStart!.toLocal();
    return '$rampLabel — ${dateFmt.format(start)}';
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({
    required this.step,
    required this.total,
    required this.titles,
  });

  final int step;
  final int total;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: MarineColors.surfaceElevated,
      padding: const EdgeInsets.fromLTRB(
        MarineSpacing.lg,
        MarineSpacing.md,
        MarineSpacing.lg,
        MarineSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STEP ${step + 1} OF $total',
            style: MarineTypography.label.copyWith(
              color: MarineColors.actionTeal,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: MarineSpacing.xs),
          Text(
            titles[step],
            style: MarineTypography.headingMedium.copyWith(
              color: MarineColors.onDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.isLast,
    required this.canContinue,
    required this.canSave,
    required this.saving,
    required this.showBack,
    required this.onBack,
    required this.onContinue,
    required this.onSave,
  });

  final bool isLast;
  final bool canContinue;
  final bool canSave;
  final bool saving;
  final bool showBack;
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          MarineSpacing.lg,
          MarineSpacing.md,
          MarineSpacing.lg,
          MarineSpacing.md,
        ),
        decoration: const BoxDecoration(
          color: MarineColors.surfaceElevated,
          border: Border(
            top: BorderSide(color: MarineColors.divider),
          ),
        ),
        child: Row(
          children: [
            if (showBack)
              TextButton(
                onPressed: onBack,
                child: const Text('Back'),
              ),
            const Spacer(),
            if (isLast)
              ElevatedButton(
                onPressed: canSave ? onSave : null,
                child: saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : const Text('Save trip'),
              )
            else
              ElevatedButton(
                onPressed: canContinue ? onContinue : null,
                child: const Text('Continue'),
              ),
          ],
        ),
      ),
    );
  }
}

class _RampStep extends ConsumerStatefulWidget {
  const _RampStep({required this.selected, required this.onPick});

  final BoatRampRecord? selected;
  final ValueChanged<BoatRampRecord> onPick;

  @override
  ConsumerState<_RampStep> createState() => _RampStepState();
}

class _RampStepState extends ConsumerState<_RampStep> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final rampsAsync = ref.watch(osmRampsProvider);
    final positionAsync = ref.watch(currentPositionProvider);
    final origin = positionAsync.maybeWhen(
      data: (p) => LatLng(latitude: p.latitude, longitude: p.longitude),
      orElse: () => const LatLng(latitude: 27.94, longitude: -82.45),
    );
    return rampsAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MarineSpacing.xxl),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Text(
        'Could not load ramps: $e',
        style: const TextStyle(color: MarineColors.onDark),
      ),
      data: (ramps) {
        final filtered = _filterAndSort(ramps, _query, origin);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search ramps by name…',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: MarineColors.surfaceElevated,
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: MarineColors.onDark),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: MarineSpacing.sm),
            for (final r in filtered)
              _RampTile(
                ramp: r,
                origin: origin,
                hasGps: positionAsync.hasValue,
                isSelected: widget.selected?.id == r.id,
                onTap: () => widget.onPick(r),
              ),
          ],
        );
      },
    );
  }

  List<BoatRampRecord> _filterAndSort(
    List<BoatRampRecord> ramps,
    String query,
    LatLng origin,
  ) {
    final q = query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? ramps
        : ramps.where((r) {
            final name = (r.name ?? '').toLowerCase();
            return name.contains(q);
          }).toList();
    final sorted = [...filtered]..sort((a, b) {
        return a.distanceNmTo(origin).compareTo(b.distanceNmTo(origin));
      });
    return sorted.take(50).toList();
  }
}

class _RampTile extends StatelessWidget {
  const _RampTile({
    required this.ramp,
    required this.origin,
    required this.hasGps,
    required this.isSelected,
    required this.onTap,
  });

  final BoatRampRecord ramp;
  final LatLng origin;
  final bool hasGps;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MarineSpacing.md,
            vertical: MarineSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: MarineColors.onDark.withAlpha(20),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ramp.name ?? 'Unnamed ramp',
                      style: MarineTypography.bodyMedium.copyWith(
                        color: MarineColors.onDark,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${ramp.distanceNmTo(origin).toStringAsFixed(1)} nm '
                      'from ${hasGps ? "vessel" : "default"}',
                      style: MarineTypography.bodySmall.copyWith(
                        color: MarineColors.onDark.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: MarineColors.actionTeal,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeStep extends StatelessWidget {
  const _TimeStep({
    required this.start,
    required this.end,
    required this.onChange,
  });

  final DateTime? start;
  final DateTime? end;
  final void Function(DateTime, DateTime) onChange;

  static final _fmt = DateFormat('EEE MMM d, h:mm a');

  @override
  Widget build(BuildContext context) {
    final startLabel = start == null ? 'Pick start time' : _fmt.format(start!);
    final endLabel = end == null ? 'Pick end time' : _fmt.format(end!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'When does the trip run? Defaults to today 6 AM – 6 PM.',
          style: MarineTypography.bodyMedium.copyWith(
            color: MarineColors.onDark.withAlpha(200),
          ),
        ),
        const SizedBox(height: MarineSpacing.lg),
        OutlinedButton.icon(
          icon: const Icon(Icons.schedule),
          label: Text(startLabel),
          onPressed: () => _pick(context, isStart: true),
          style: _outlinedStyle,
        ),
        const SizedBox(height: MarineSpacing.sm),
        OutlinedButton.icon(
          icon: const Icon(Icons.schedule),
          label: Text(endLabel),
          onPressed: () => _pick(context, isStart: false),
          style: _outlinedStyle,
        ),
      ],
    );
  }

  static final _outlinedStyle = OutlinedButton.styleFrom(
    foregroundColor: MarineColors.onDark,
    side: const BorderSide(color: MarineColors.divider),
    padding: const EdgeInsets.symmetric(
      horizontal: MarineSpacing.md,
      vertical: MarineSpacing.md,
    ),
  );

  Future<void> _pick(BuildContext context, {required bool isStart}) async {
    final initial = isStart ? (start ?? _todayAt(6)) : (end ?? _todayAt(18));
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    final newStart = isStart ? picked : (start ?? _todayAt(6));
    var newEnd = isStart ? (end ?? _todayAt(18)) : picked;
    if (!newEnd.isAfter(newStart)) {
      newEnd = newStart.add(const Duration(hours: 6));
    }
    onChange(newStart, newEnd);
  }

  static DateTime _todayAt(int hour) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour);
  }
}

class _SpeciesStep extends ConsumerWidget {
  const _SpeciesStep({required this.selectedId, required this.onPick});

  final String? selectedId;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speciesAsync = ref.watch(availableSpeciesProvider);
    return speciesAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MarineSpacing.xxl),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Text(
        'Could not load species: $e',
        style: const TextStyle(color: MarineColors.onDark),
      ),
      data: (records) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final r in records)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onPick(r.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MarineSpacing.md,
                      vertical: MarineSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MarineColors.onDark.withAlpha(20),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            r.commonNames.isNotEmpty
                                ? r.commonNames.first
                                : r.id,
                            style: MarineTypography.bodyLarge.copyWith(
                              color: MarineColors.onDark,
                              fontWeight: r.id == selectedId
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (r.id == selectedId)
                          const Icon(
                            Icons.check_circle,
                            color: MarineColors.actionTeal,
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({required this.draft});

  final PlanTripDraft draft;

  @override
  Widget build(BuildContext context) {
    final ramp = draft.ramp;
    final start = draft.plannedStart;
    final end = draft.plannedEnd;
    if (ramp == null || start == null || end == null) {
      return const Text(
        'Complete the previous steps first.',
        style: TextStyle(color: MarineColors.onDark),
      );
    }
    final fmt = DateFormat('EEE MMM d, h:mm a');
    final bounds = LatLngBounds.fromCenter(
      center: ramp.location,
      radiusNm: _defaultTripRadiusNm,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ReviewRow(label: 'Ramp', value: ramp.name ?? 'Unnamed (${ramp.id})'),
        _ReviewRow(
          label: 'Trip area',
          value: '${_defaultTripRadiusNm.toInt()} nm '
              'around ramp · ${bounds.heightNm.toStringAsFixed(0)}×'
              '${bounds.widthNm.toStringAsFixed(0)} nm',
        ),
        _ReviewRow(label: 'Start', value: fmt.format(start)),
        _ReviewRow(label: 'End', value: fmt.format(end)),
        _ReviewRow(label: 'Species', value: draft.targetSpeciesId ?? '—'),
        const SizedBox(height: MarineSpacing.lg),
        Text(
          'Saving creates the trip and sets it as your active trip. '
          'Tile + score-grid pre-fetch lands in later slices.',
          style: MarineTypography.bodySmall.copyWith(
            color: MarineColors.onDark.withAlpha(170),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MarineSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: MarineTypography.bodySmall.copyWith(
                color: MarineColors.onDark.withAlpha(150),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: MarineTypography.bodyMedium.copyWith(
                color: MarineColors.onDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
