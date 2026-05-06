import 'dart:async';

import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:ai_marine_engine/state/engine_providers.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
import 'package:ai_marine_engine/ui/picker/species_chip.dart';
import 'package:ai_marine_engine/ui/picker/species_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _conditionProfile = ConditionProfile(
  optimalTemp: TemperatureRange(minF: 60, maxF: 68, idealF: 64),
  toleratedTemp: TemperatureRange(minF: 50, maxF: 75, idealF: 64),
  depthPreference: DepthPreference(minFt: 5, maxFt: 50, idealFt: 20),
  tidePreference: TidePreference(phaseWeights: {}),
  solunarSensitivity: SolunarSensitivity.medium,
  lunarSensitivity: LunarSensitivity.low,
  weatherSensitivity: WeatherSensitivity(
    risingPressureFactor: 1.0,
    fallingPressureFactor: 1.0,
    frontalPassageFactor: 1.0,
    cloudCoverPreference: 0.5,
  ),
  currentPreference: CurrentPreference(
    minKnots: 0,
    maxKnots: 4,
    idealKnots: 1.5,
  ),
);

SpeciesRecord _species({
  required String id,
  required List<String> commonNames,
}) =>
    SpeciesRecord(
      id: id,
      scientificName: '',
      commonNames: commonNames,
      schemaVersion: '1.0',
      curationVersion: '0.0.1',
      sizeClasses: const [],
      migrationModel: const MigrationModel(
        spatialRange: GeoPolygon(rings: []),
        regionalCurves: [],
      ),
      conditionProfile: _conditionProfile,
      regulatoryProfile: const RegulatoryProfile(),
      confidence: ConfidenceLevel.exploratory,
    );

Widget _harness({
  required String selectedId,
  required List<SpeciesRecord> available,
}) {
  return ProviderScope(
    overrides: [
      selectedSpeciesIdProvider.overrideWith((ref) => selectedId),
      availableSpeciesProvider.overrideWith((ref) async => available),
    ],
    child: MaterialApp(
      theme: buildMarineTheme(),
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.topLeft,
              child: SpeciesChip(),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('SpeciesChip', () {
    testWidgets("renders the selected species' first common name",
        (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedId: 'common-snook',
          available: [
            _species(
              id: 'common-snook',
              commonNames: ['Snook', 'Common snook'],
            ),
            _species(id: 'red-drum', commonNames: ['Redfish']),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Snook'), findsOneWidget);
    });

    testWidgets('shows the chevron-down indicator', (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedId: 'common-snook',
          available: [
            _species(id: 'common-snook', commonNames: ['Snook']),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets(
      'falls back to a humanised id while species data is still loading',
      (tester) async {
        // Override availableSpeciesProvider with a future that never
        // resolves so the AsyncValue stays in `loading` for the test —
        // the chip's `maybeWhen.orElse` should kick in and render the
        // humanised id rather than blank.
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              selectedSpeciesIdProvider.overrideWith((ref) => 'common-snook'),
              availableSpeciesProvider.overrideWith(
                (ref) => Completer<List<SpeciesRecord>>().future,
              ),
            ],
            child: MaterialApp(
              theme: buildMarineTheme(),
              home: const Scaffold(
                body: SafeArea(child: SpeciesChip()),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(find.text('Common snook'), findsOneWidget);
      },
    );

    testWidgets('tap opens the SpeciesPickerSheet', (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedId: 'common-snook',
          available: [
            _species(id: 'common-snook', commonNames: ['Snook']),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SpeciesChip));
      await tester.pumpAndSettle();
      expect(find.byType(SpeciesPickerSheet), findsOneWidget);
    });
  });
}
