import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/species/models/condition_profile.dart';
import 'package:ai_marine_engine/data/species/models/migration_model.dart';
import 'package:ai_marine_engine/data/species/models/regulatory_profile.dart';
import 'package:ai_marine_engine/data/species/models/species_record.dart';
import 'package:ai_marine_engine/state/engine_providers.dart';
import 'package:ai_marine_engine/ui/design/theme.dart';
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
  String scientificName = '',
}) =>
    SpeciesRecord(
      id: id,
      scientificName: scientificName,
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

/// Wraps the sheet in a host widget that surfaces it via
/// [showModalBottomSheet] so the test exercises the same code path
/// as production (where it's opened by [SpeciesChip]).
Widget _harness({
  required String selectedId,
  required List<SpeciesRecord> available,
  void Function(WidgetRef)? onRefReady,
}) {
  return ProviderScope(
    overrides: [
      selectedSpeciesIdProvider.overrideWith((ref) => selectedId),
      availableSpeciesProvider.overrideWith((ref) async => available),
    ],
    child: MaterialApp(
      theme: buildMarineTheme(),
      home: Consumer(
        builder: (context, ref, _) {
          if (onRefReady != null) onRefReady(ref);
          return Scaffold(
            body: Builder(
              builder: (ctx) => Center(
                child: ElevatedButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: ctx,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const SpeciesPickerSheet(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

Future<void> _openPicker(WidgetTester tester) async {
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

void main() {
  group('SpeciesPickerSheet', () {
    testWidgets(
        "renders TARGET SPECIES label and every species' first "
        'common name', (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedId: 'common-snook',
          available: [
            _species(id: 'common-snook', commonNames: ['Snook']),
            _species(id: 'red-drum', commonNames: ['Redfish']),
            _species(id: 'spotted-seatrout', commonNames: ['Spotted seatrout']),
          ],
        ),
      );
      await _openPicker(tester);
      expect(find.text('TARGET SPECIES'), findsOneWidget);
      expect(find.text('Snook'), findsOneWidget);
      expect(find.text('Redfish'), findsOneWidget);
      expect(find.text('Spotted seatrout'), findsOneWidget);
    });

    testWidgets('shows the scientific name italicised below the common name',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedId: 'common-snook',
          available: [
            _species(
              id: 'common-snook',
              commonNames: ['Snook'],
              scientificName: 'Centropomus undecimalis',
            ),
          ],
        ),
      );
      await _openPicker(tester);
      expect(find.text('Centropomus undecimalis'), findsOneWidget);
    });

    testWidgets('marks the currently selected species with a check icon',
        (tester) async {
      await tester.pumpWidget(
        _harness(
          selectedId: 'red-drum',
          available: [
            _species(id: 'common-snook', commonNames: ['Snook']),
            _species(id: 'red-drum', commonNames: ['Redfish']),
          ],
        ),
      );
      await _openPicker(tester);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets(
      'tapping a row writes the species id and dismisses the sheet',
      (tester) async {
        late WidgetRef capturedRef;
        await tester.pumpWidget(
          _harness(
            selectedId: 'common-snook',
            available: [
              _species(id: 'common-snook', commonNames: ['Snook']),
              _species(id: 'red-drum', commonNames: ['Redfish']),
            ],
            onRefReady: (r) => capturedRef = r,
          ),
        );
        await _openPicker(tester);
        await tester.tap(find.text('Redfish'));
        await tester.pumpAndSettle();
        expect(find.byType(SpeciesPickerSheet), findsNothing);
        expect(
          capturedRef.read(selectedSpeciesIdProvider),
          'red-drum',
        );
      },
    );
  });
}
