import 'package:freezed_annotation/freezed_annotation.dart';

import 'condition_profile.dart';
import 'migration_model.dart';
import 'regulatory_profile.dart';

part 'species_record.freezed.dart';
part 'species_record.g.dart';

/// Top-level species data record. Mirrors TDD §3.3.1. The class hierarchy
/// shadows the bundled JSON exactly; this is the IP locus.
///
/// One JSON file per species, loaded lazily by [SpeciesDatabase] in Phase 3
/// (`lib/data/species/species_database.dart`).
@freezed
class SpeciesRecord with _$SpeciesRecord {
  const factory SpeciesRecord({
    required String id,
    required String scientificName,
    required List<String> commonNames,
    required String schemaVersion,
    required String curationVersion,
    required List<SizeClass> sizeClasses,
    required MigrationModel migrationModel,
    required ConditionProfile conditionProfile,
    required RegulatoryProfile regulatoryProfile,
    required ConfidenceLevel confidence,

    /// Per-field provenance citations. Maps a calculator variable name
    /// (e.g. `optimalTemp`, `tidePreference`) to either a source URL
    /// or the literal string `unverified` when no authoritative source
    /// could be found. Captured per-species when authoring the JSON
    /// data file; surfaces in the recommendation card's "data quality"
    /// notes (Phase 6+) so users see which numbers are pinned vs
    /// best-guess.
    @Default(<String, String>{}) Map<String, String> dataProvenance,
  }) = _SpeciesRecord;

  factory SpeciesRecord.fromJson(Map<String, dynamic> json) =>
      _$SpeciesRecordFromJson(json);
}

/// A length-banded sub-class within a species (e.g. schoolie vs trophy
/// stripers). [overrideProfile] lets a class swap in different optimal
/// temps, depth preferences, etc., when the size-band's biology diverges
/// from the species-level default.
@freezed
class SizeClass with _$SizeClass {
  const factory SizeClass({
    required String id,
    required String displayName,
    double? minLengthInches,
    double? maxLengthInches,
    ConditionProfile? overrideProfile,
  }) = _SizeClass;

  factory SizeClass.fromJson(Map<String, dynamic> json) =>
      _$SizeClassFromJson(json);
}

/// Curation-confidence grade for a species record.
///
/// - [exploratory]: thin data, expected to mis-rank; used for early dev.
/// - [calibrated]: tuned against a calibration tuple set; engine output
///   tracks reality within tolerance.
/// - [validated]: month-plus of beta-cohort field use confirms calibration.
enum ConfidenceLevel { exploratory, calibrated, validated }
