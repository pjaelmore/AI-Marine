import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/source_adapter.dart';
import 'package:ai_marine_engine/data/sources/source_registry.dart';
import 'package:flutter_test/flutter_test.dart';

class _FixedAdapter extends SourceAdapter<double> {
  _FixedAdapter({
    required this.value,
    required this.serves,
    required this.tag,
    this.failure,
  });

  final double value;
  final bool serves;
  final String tag;
  final SourceException? failure;

  @override
  DataSource get sourceId => DataSource.noaaNdbc;

  @override
  Duration get defaultTtl => const Duration(minutes: 60);

  @override
  bool canServe(LatLng location, DateTime time) => serves;

  @override
  Future<ConditionResult<double>> fetch(
    LatLng location,
    DateTime time,
  ) async {
    if (failure != null) throw failure!;
    return ConditionResult<double>(
      value: value,
      unit: 'F',
      source: DataSource.noaaNdbc,
      sourceDetails: SourceDetails(stationId: tag),
      fetchedAt: time,
      validUntil: time.add(defaultTtl),
      confidence: 0.9,
    );
  }
}

void main() {
  const here = LatLng(latitude: 42.36, longitude: -70.55);
  final now = DateTime.utc(2026, 5, 22, 18, 0);

  group('SourceRegistry', () {
    test('with no adapters returns the unavailable sentinel', () async {
      final registry = SourceRegistry();
      final result = await registry.resolve<double>(
        location: here,
        time: now,
        unavailableValue: double.nan,
      );
      expect(result.source, DataSource.unavailable);
      expect(result.confidence, 0);
      expect(result.value.isNaN, isTrue);
    });

    test('returns the first adapter whose canServe passes', () async {
      final registry = SourceRegistry()
        ..register<double>(
          _FixedAdapter(value: 60, serves: true, tag: 'first'),
        )
        ..register<double>(
          _FixedAdapter(value: 70, serves: true, tag: 'second'),
        );

      final result = await registry.resolve<double>(
        location: here,
        time: now,
        unavailableValue: double.nan,
      );
      expect(result.value, 60);
      expect(result.sourceDetails.stationId, 'first');
    });

    test('skips adapters whose canServe returns false', () async {
      final registry = SourceRegistry()
        ..register<double>(
          _FixedAdapter(value: 60, serves: false, tag: 'cant'),
        )
        ..register<double>(
          _FixedAdapter(value: 70, serves: true, tag: 'can'),
        );

      final result = await registry.resolve<double>(
        location: here,
        time: now,
        unavailableValue: double.nan,
      );
      expect(result.value, 70);
      expect(result.sourceDetails.stationId, 'can');
    });

    test('falls through SourceException to the next adapter', () async {
      final registry = SourceRegistry()
        ..register<double>(
          _FixedAdapter(
            value: 60,
            serves: true,
            tag: 'fails',
            failure: const SourceException(
              'simulated upstream timeout',
              source: DataSource.noaaNdbc,
            ),
          ),
        )
        ..register<double>(
          _FixedAdapter(value: 70, serves: true, tag: 'succeeds'),
        );

      final result = await registry.resolve<double>(
        location: here,
        time: now,
        unavailableValue: double.nan,
      );
      expect(result.value, 70);
      expect(result.sourceDetails.stationId, 'succeeds');
    });

    test(
      'returns unavailable when every candidate either refuses or fails',
      () async {
        final registry = SourceRegistry()
          ..register<double>(
            _FixedAdapter(value: 60, serves: false, tag: 'cant'),
          )
          ..register<double>(
            _FixedAdapter(
              value: 70,
              serves: true,
              tag: 'failing',
              failure: const SourceException('boom'),
            ),
          );

        final result = await registry.resolve<double>(
          location: here,
          time: now,
          unavailableValue: double.nan,
        );
        expect(result.source, DataSource.unavailable);
      },
    );

    test('candidateCount reflects registrations', () {
      final registry = SourceRegistry()
        ..register<double>(
          _FixedAdapter(value: 60, serves: true, tag: 'a'),
        )
        ..register<double>(
          _FixedAdapter(value: 60, serves: true, tag: 'b'),
        );
      expect(registry.candidateCount<double>(), 2);
      expect(registry.candidateCount<int>(), 0);
    });
  });
}
