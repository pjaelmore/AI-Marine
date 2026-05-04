import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'models/species_record.dart';

/// Loads species data files from the bundled assets and caches them.
///
/// Species data lives in two places:
///   - `assets/species/index.json` — a manifest listing every species
///     id available to the app.
///   - `assets/species/<id>.json` — one file per species, parsed into
///     [SpeciesRecord] via the freezed `fromJson` factory.
///
/// The two-file layout (manifest + per-species file) is forced by
/// Flutter's asset system: `rootBundle` doesn't enumerate directories,
/// it loads paths you name up front. The manifest is the list of
/// known names. Adding a species is a 3-step ritual: drop the JSON
/// file, append the id to the manifest, ensure the asset glob in
/// `pubspec.yaml` covers it.
class SpeciesDatabase {
  SpeciesDatabase._();

  /// Singleton instance — Riverpod wires this in v1.6+; until then
  /// callers can construct via [SpeciesDatabase.create] which mirrors
  /// the loadStations() pattern from the source adapters.
  static SpeciesDatabase create() => SpeciesDatabase._();

  /// Asset path for the manifest. Public so the Riverpod provider
  /// and tests can reference one constant rather than two stringly
  /// typed copies.
  static const String indexAssetPath = 'assets/species/index.json';

  static String _speciesAssetPath(String id) => 'assets/species/$id.json';

  final Map<String, SpeciesRecord> _cache = {};
  List<String>? _knownIds;

  /// Loads the manifest. Call once at app startup before [load].
  /// Subsequent calls are no-ops; forcing a reload is a deliberate
  /// design choice we'd add later if species data updates need to
  /// happen mid-session.
  Future<void> loadIndex() async {
    if (_knownIds != null) return;
    final raw = await rootBundle.loadString(indexAssetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    _knownIds = (json['speciesIds'] as List).cast<String>();
  }

  /// Species ids in the manifest. Empty until [loadIndex] runs.
  List<String> get availableSpeciesIds =>
      _knownIds == null ? const [] : List.unmodifiable(_knownIds!);

  /// Loads a single species record. Caches in memory after first
  /// load; repeated calls return the cached instance.
  Future<SpeciesRecord> load(String id) async {
    final cached = _cache[id];
    if (cached != null) return cached;
    final raw = await rootBundle.loadString(_speciesAssetPath(id));
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final record = SpeciesRecord.fromJson(json);
    _cache[id] = record;
    return record;
  }

  /// Loads every species named in the manifest in parallel. Useful
  /// for the species-picker UI which wants to show all species at
  /// once. Each species is then cached so subsequent [load] calls
  /// are synchronous in spirit.
  Future<List<SpeciesRecord>> loadAll() async {
    await loadIndex();
    return Future.wait(_knownIds!.map(load));
  }

  /// Returns a cached record without touching the asset bundle. Null
  /// if [load] hasn't been called for this id yet. Lets a UI render
  /// what's already loaded without forcing an `await`.
  SpeciesRecord? getCached(String id) => _cache[id];

  /// Test seam — bypasses the asset bundle.
  void seedForTesting({
    required List<String> ids,
    required Map<String, SpeciesRecord> records,
  }) {
    _knownIds = List.unmodifiable(ids);
    _cache
      ..clear()
      ..addAll(records);
  }
}
