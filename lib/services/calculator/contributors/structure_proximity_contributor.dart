import '../../../core/types/conditions.dart';
import '../../../core/types/score_result.dart';
import '../../../data/species/models/condition_profile.dart';

const double _structureRangeMax = 1.0;

/// Additive structure-proximity contributor (TDD §6).
///
/// Reads the resolved [StructureType] at the lookup location and
/// matches it against the species's [ConditionProfile.structurePreferences].
/// On match, the species's preference weight is the contribution
/// value, in `[0, _structureRangeMax]`.
///
/// **No data → 0.** [StructureType.unknown] (and any unmapped type)
/// contributes nothing rather than penalizing — that's what
/// contributors are for, and structure data isn't always available
/// (ENC bathymetry inference is Phase 7+).
///
/// **Distance falloff is intentionally not modeled here.** The
/// `StructureInfo.type` we receive is already the type at this
/// location — the contour-transition distance in
/// `StructureInfo.distanceToContourTransitionM` is a richer signal
/// for a future refinement, but v1 just trusts the type tag.
ContributorApplication evaluateStructureProximityContributor({
  required StructureInfo structure,
  required List<StructurePreference> preferences,
}) {
  if (structure.type == StructureType.unknown) {
    return const ContributorApplication(
      name: 'structure_proximity',
      value: 0,
      rangeMax: _structureRangeMax,
      description: 'Structure type unknown at this location',
    );
  }

  StructurePreference? match;
  for (final pref in preferences) {
    if (pref.type == structure.type) {
      match = pref;
      break;
    }
  }
  if (match == null) {
    return ContributorApplication(
      name: 'structure_proximity',
      value: 0,
      rangeMax: _structureRangeMax,
      description: 'No species preference for ${_label(structure.type)}',
    );
  }

  final value = match.weight.clamp(0.0, _structureRangeMax);
  return ContributorApplication(
    name: 'structure_proximity',
    value: value,
    rangeMax: _structureRangeMax,
    description: '${_label(structure.type)} matches species preference '
        '(weight ${match.weight.toStringAsFixed(2)})',
  );
}

String _label(StructureType type) {
  switch (type) {
    case StructureType.flatBottom:
      return 'flat bottom';
    case StructureType.sandFlat:
      return 'sand flat';
    case StructureType.channel:
      return 'channel';
    case StructureType.channelEdge:
      return 'channel edge';
    case StructureType.ledge:
      return 'ledge';
    case StructureType.dropOff:
      return 'drop-off';
    case StructureType.reef:
      return 'reef';
    case StructureType.wreck:
      return 'wreck';
    case StructureType.weedLine:
      return 'weed line';
    case StructureType.shoal:
      return 'shoal';
    case StructureType.ripCurrent:
      return 'rip current';
    case StructureType.unknown:
      return 'unknown';
  }
}
