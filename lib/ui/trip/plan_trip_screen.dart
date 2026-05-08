import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/types/lat_lng.dart';
import '../../core/types/trip_plan.dart';
import '../../data/sources/ndbc/buoy_station.dart';
import '../../state/component_providers.dart';
import '../../state/engine_providers.dart';
import '../../state/plan_trip_draft_provider.dart';
import '../../state/trip_providers.dart';
import '../../state/vessel_providers.dart';
import '../design/colors.dart';
import '../design/spacing.dart';
import '../design/typography.dart';

/// Default trip-area radius around the picked station, in nautical
/// miles. Covers most inshore + nearshore offshore fishing; bbox
/// dragging to expand for offshore runs lands in 13a.3.
const _defaultTripRadiusNm = 15.0;

/// 4-step "Plan a trip" wizard. The trip's launch anchor is an NDBC
/// buoy station — picking one of the bundled stations gives a known
/// saltwater reference point with id + description, and the score
/// grid + tile downloader in later slices key off `station.location`
/// for the trip bbox.
///
/// Custom layout instead of Material's Stepper because the latter
/// renders invisibly on the marine dark theme.
class PlanTripScreen extends ConsumerStatefulWidget {
  const PlanTripScreen({super.key});

  @override
  ConsumerState<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends ConsumerState<PlanTripScreen> {
  int _step = 0;
  bool _saving = false;

  static const _stepTitles = [
    'NDBC station',
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
        backgroundColor: MarineColors.surfaceElevated,
        foregroundColor: MarineColors.onDark,
        title: const Text('Plan a trip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeader(
            step: _step,
            total: _stepTitles.length,
            titles: _stepTitles,
          ),
          Expanded(
            child: ColoredBox(
              color: MarineColors.deepMarine,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(MarineSpacing.lg),
                child: _stepBody(draft),
              ),
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

  Widget _stepBody(PlanTripDraft draft) {
    switch (_step) {
      case 0:
        return _StationStep(
          selected: draft.station,
          onPick: (s) {
            ref.read(planTripDraftProvider.notifier).setStation(s);
            setState(() => _step = 1);
          },
        );
      case 1:
        return _TimeStep(
          start: draft.plannedStart,
          end: draft.plannedEnd,
          onChange: (s, e) {
            ref.read(planTripDraftProvider.notifier).setTimeWindow(s, e);
          },
        );
      case 2:
        return _SpeciesStep(
          selectedId: draft.targetSpeciesId,
          onPick: (id) =>
              ref.read(planTripDraftProvider.notifier).setSpecies(id),
        );
      default:
        return _ReviewStep(draft: draft);
    }
  }

  bool _canAdvanceTo(int target, PlanTripDraft draft) {
    if (target <= 0) return true;
    if (target >= 1 && draft.station == null) return false;
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
      final station = draft.station!;
      final bounds = LatLngBounds.fromCenter(
        center: station.location,
        radiusNm: _defaultTripRadiusNm,
      );
      final plan = TripPlan(
        id: 'trip-${DateTime.now().toUtc().millisecondsSinceEpoch}',
        name: draft.name?.trim().isNotEmpty ?? false
            ? draft.name!
            : _autoName(draft, station),
        bounds: bounds,
        plannedStart: draft.plannedStart!.toUtc(),
        plannedEnd: draft.plannedEnd!.toUtc(),
        targetSpeciesId: draft.targetSpeciesId!,
        createdAt: DateTime.now().toUtc(),
        cacheStatus: TripCacheStatus(stationId: station.id),
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

  String _autoName(PlanTripDraft draft, BuoyStation station) {
    final dateFmt = DateFormat('MMM d');
    final start = draft.plannedStart!.toLocal();
    return 'NDBC ${station.id} — ${dateFmt.format(start)}';
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
            // Override marine theme's full-width minimumSize so these
            // inline buttons size to intrinsic content.
            if (isLast)
              ElevatedButton(
                onPressed: canSave ? onSave : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 44),
                ),
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 44),
                ),
                child: const Text('Continue'),
              ),
          ],
        ),
      ),
    );
  }
}

class _StationStep extends ConsumerStatefulWidget {
  const _StationStep({required this.selected, required this.onPick});

  final BuoyStation? selected;
  final ValueChanged<BuoyStation> onPick;

  @override
  ConsumerState<_StationStep> createState() => _StationStepState();
}

class _StationStepState extends ConsumerState<_StationStep> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final stationsAsync = ref.watch(ndbcStationsProvider);
    final positionAsync = ref.watch(currentPositionProvider);
    final origin = positionAsync.maybeWhen(
      data: (p) => LatLng(latitude: p.latitude, longitude: p.longitude),
      orElse: () => const LatLng(latitude: 27.94, longitude: -82.45),
    );
    return stationsAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MarineSpacing.xxl),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Text(
        'Could not load stations: $e',
        style: const TextStyle(color: MarineColors.onDark),
      ),
      data: (stations) {
        final filtered = _filterAndSort(stations, _query, origin);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pick the NDBC station nearest where you plan to fish. The '
              'trip area is a ${_defaultTripRadiusNm.toInt()} nm bbox '
              'around the station.',
              style: MarineTypography.bodySmall.copyWith(
                color: MarineColors.onDark.withAlpha(180),
              ),
            ),
            const SizedBox(height: MarineSpacing.md),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search by station id or name…',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: MarineColors.surfaceElevated,
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: MarineColors.onDark),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: MarineSpacing.sm),
            for (final s in filtered)
              _StationTile(
                station: s,
                origin: origin,
                hasGps: positionAsync.hasValue,
                isSelected: widget.selected?.id == s.id,
                onTap: () => widget.onPick(s),
              ),
          ],
        );
      },
    );
  }

  List<BuoyStation> _filterAndSort(
    List<BuoyStation> stations,
    String query,
    LatLng origin,
  ) {
    final q = query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? stations
        : stations.where((s) {
            return s.id.toLowerCase().contains(q) ||
                s.name.toLowerCase().contains(q);
          }).toList();
    final sorted = [...filtered]..sort(
        (a, b) => a.distanceNmTo(origin).compareTo(b.distanceNmTo(origin)),
      );
    // 163 stations total — render all of them; the search box plus
    // distance sort puts the relevant ones up top either way.
    return sorted;
  }
}

class _StationTile extends StatelessWidget {
  const _StationTile({
    required this.station,
    required this.origin,
    required this.hasGps,
    required this.isSelected,
    required this.onTap,
  });

  final BuoyStation station;
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
              SizedBox(
                width: 60,
                child: Text(
                  station.id,
                  style: MarineTypography.bodyMedium.copyWith(
                    color: MarineColors.actionTeal,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: MarineTypography.bodyMedium.copyWith(
                        color: MarineColors.onDark,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${station.distanceNmTo(origin).toStringAsFixed(1)} nm '
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
    final station = draft.station;
    final start = draft.plannedStart;
    final end = draft.plannedEnd;
    if (station == null || start == null || end == null) {
      return const Text(
        'Complete the previous steps first.',
        style: TextStyle(color: MarineColors.onDark),
      );
    }
    final fmt = DateFormat('EEE MMM d, h:mm a');
    final bounds = LatLngBounds.fromCenter(
      center: station.location,
      radiusNm: _defaultTripRadiusNm,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ReviewRow(label: 'Station', value: '${station.id} · ${station.name}'),
        _ReviewRow(
          label: 'Trip area',
          value: '${_defaultTripRadiusNm.toInt()} nm '
              'around station · ${bounds.heightNm.toStringAsFixed(0)}×'
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
