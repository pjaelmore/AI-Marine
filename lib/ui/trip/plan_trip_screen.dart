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

/// Multi-step "Plan a trip" wizard. Walks the user through ramp →
/// time window → species → review, persists a [TripPlan] on save,
/// and sets it as the active trip.
class PlanTripScreen extends ConsumerStatefulWidget {
  const PlanTripScreen({super.key});

  @override
  ConsumerState<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends ConsumerState<PlanTripScreen> {
  int _step = 0;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(planTripDraftProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan a trip'),
      ),
      body: Stepper(
        currentStep: _step,
        onStepTapped: (i) {
          // Allow jumping back to earlier steps freely; jumping
          // forward only when the prior steps are complete.
          if (i <= _step || _canAdvanceTo(i, draft)) {
            setState(() => _step = i);
          }
        },
        controlsBuilder: (ctx, details) => _Controls(
          step: _step,
          isLastStep: _step == 3,
          canContinue: _canAdvanceTo(_step + 1, draft),
          canSave: draft.isComplete && !_saving,
          saving: _saving,
          onContinue: () => setState(() => _step = (_step + 1).clamp(0, 3)),
          onBack: () => setState(() => _step = (_step - 1).clamp(0, 3)),
          onSave: _save,
        ),
        steps: [
          Step(
            title: const Text('Boat ramp'),
            isActive: _step >= 0,
            state: draft.ramp != null ? StepState.complete : StepState.indexed,
            content: _RampStep(
              selected: draft.ramp,
              onPick: (r) {
                ref.read(planTripDraftProvider.notifier).setRamp(r);
                setState(() => _step = 1);
              },
            ),
          ),
          Step(
            title: const Text('Time window'),
            isActive: _step >= 1,
            state: (draft.plannedStart != null && draft.plannedEnd != null)
                ? StepState.complete
                : StepState.indexed,
            content: _TimeStep(
              start: draft.plannedStart,
              end: draft.plannedEnd,
              onChange: (s, e) {
                ref.read(planTripDraftProvider.notifier).setTimeWindow(s, e);
              },
            ),
          ),
          Step(
            title: const Text('Target species'),
            isActive: _step >= 2,
            state: (draft.targetSpeciesId?.isNotEmpty ?? false)
                ? StepState.complete
                : StepState.indexed,
            content: _SpeciesStep(
              selectedId: draft.targetSpeciesId,
              onPick: (id) =>
                  ref.read(planTripDraftProvider.notifier).setSpecies(id),
            ),
          ),
          Step(
            title: const Text('Review'),
            isActive: _step >= 3,
            state: StepState.indexed,
            content: _ReviewStep(draft: draft),
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

class _Controls extends StatelessWidget {
  const _Controls({
    required this.step,
    required this.isLastStep,
    required this.canContinue,
    required this.canSave,
    required this.saving,
    required this.onContinue,
    required this.onBack,
    required this.onSave,
  });

  final int step;
  final bool isLastStep;
  final bool canContinue;
  final bool canSave;
  final bool saving;
  final VoidCallback onContinue;
  final VoidCallback onBack;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MarineSpacing.md),
      child: Row(
        children: [
          if (isLastStep)
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
          if (step > 0) ...[
            const SizedBox(width: MarineSpacing.md),
            TextButton(onPressed: onBack, child: const Text('Back')),
          ],
        ],
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
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: MarineSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Text('Could not load ramps: $e'),
      data: (ramps) {
        final filtered = _filterAndSort(ramps, _query, origin);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search ramps by name…',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: MarineSpacing.sm),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final r = filtered[i];
                  final isSelected = widget.selected?.id == r.id;
                  return ListTile(
                    title: Text(r.name ?? 'Unnamed ramp'),
                    subtitle: Text(
                      '${r.distanceNmTo(origin).toStringAsFixed(1)} nm '
                      'from ${positionAsync.hasValue ? "vessel" : "default"}',
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check,
                            color: MarineColors.actionTeal,
                          )
                        : null,
                    onTap: () => widget.onPick(r),
                  );
                },
              ),
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
    // Cap the rendered list — 2k+ items is too many for a Stepper
    // section. Distance-sorted, so the closest 50 are the relevant
    // ones for the user.
    return sorted.take(50).toList();
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
    final startLabel = start == null ? 'Start time' : _fmt.format(start!);
    final endLabel = end == null ? 'End time' : _fmt.format(end!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          icon: const Icon(Icons.schedule),
          label: Text(startLabel),
          onPressed: () => _pick(context, isStart: true),
        ),
        const SizedBox(height: MarineSpacing.sm),
        OutlinedButton.icon(
          icon: const Icon(Icons.schedule),
          label: Text(endLabel),
          onPressed: () => _pick(context, isStart: false),
        ),
        const SizedBox(height: MarineSpacing.sm),
        Text(
          'Default is today 6 AM – 6 PM. Adjust to match your trip.',
          style: MarineTypography.bodySmall.copyWith(
            color: MarineColors.onDark.withAlpha(170),
          ),
        ),
      ],
    );
  }

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
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: MarineSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Text('Could not load species: $e'),
      data: (records) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final r in records)
              ListTile(
                title: Text(
                  r.commonNames.isNotEmpty ? r.commonNames.first : r.id,
                ),
                trailing: r.id == selectedId
                    ? const Icon(
                        Icons.check,
                        color: MarineColors.actionTeal,
                      )
                    : null,
                onTap: () => onPick(r.id),
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
      return const Text('Complete the previous steps first.');
    }
    final fmt = DateFormat('EEE MMM d, h:mm a');
    final bounds = LatLngBounds.fromCenter(
      center: ramp.location,
      radiusNm: _defaultTripRadiusNm,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Row(label: 'Ramp', value: ramp.name ?? 'Unnamed (${ramp.id})'),
        _Row(
          label: 'Trip area',
          value: '${_defaultTripRadiusNm.toInt()} nm '
              'around ramp · ${bounds.heightNm.toStringAsFixed(0)}×'
              '${bounds.widthNm.toStringAsFixed(0)} nm',
        ),
        _Row(label: 'Start', value: fmt.format(start)),
        _Row(label: 'End', value: fmt.format(end)),
        _Row(label: 'Species', value: draft.targetSpeciesId ?? '—'),
        const SizedBox(height: MarineSpacing.sm),
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

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MarineSpacing.xs),
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
