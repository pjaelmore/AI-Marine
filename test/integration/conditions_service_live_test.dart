import 'package:ai_marine_engine/core/types/condition_result.dart';
import 'package:ai_marine_engine/core/types/lat_lng.dart';
import 'package:ai_marine_engine/data/sources/dio_setup.dart';
import 'package:ai_marine_engine/data/sources/ndbc/ndbc_adapter.dart';
import 'package:ai_marine_engine/data/sources/nws_forecast/nws_adapter.dart';
import 'package:ai_marine_engine/data/sources/solunar/solunar_adapter.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_adapter.dart';
import 'package:ai_marine_engine/services/conditions/conditions_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 3 DoD §3.4 live integration test.
///
/// "From a Dart REPL or test, you can call
/// `conditionsService.getWaterTemp(LatLng(42.36, -70.55), DateTime.now())`
/// and get back the current Boston Harbor water temperature from the real
/// NDBC buoy. Same for tide, wind, waves, and solunar."
///
/// This test hits live NOAA. It requires network access and is sensitive
/// to NOAA outages; CI on Ubuntu has stable connectivity and runs it on
/// every push. Locally on Windows it runs too (no sqlite3 needed) — the
/// only requirement is internet.
///
/// Tagged `live` so a future `flutter test --exclude-tags live` opt-out
/// is available if NOAA flakiness ever blocks a release branch.
void main() {
  group('ConditionsService — live NOAA queries (TDD §3.4 DoD)', () {
    const bostonHarbor = LatLng(latitude: 42.36, longitude: -70.55);
    late ConditionsServiceImpl service;

    setUpAll(() async {
      // testWidgets-style binding so rootBundle can resolve project assets.
      TestWidgetsFlutterBinding.ensureInitialized();
      final dio = buildDio();
      final ndbc = NdbcAdapter(http: dio);
      await ndbc.loadStations();
      final tides = TidesAndCurrentsAdapter(http: dio);
      await tides.loadStations();
      service = ConditionsServiceImpl(
        ndbc: ndbc,
        tides: tides,
        nws: NwsAdapter(http: dio),
        solunar: SolunarAdapter(),
      );
    });

    test(
      'getWaterTemp returns a plausible NE-US sea-surface temperature',
      () async {
        final r =
            await service.getWaterTemp(bostonHarbor, DateTime.now().toUtc());
        if (r.source == DataSource.unavailable) {
          fail(
            'NDBC water-temp returned unavailable; either NOAA is down, '
            'no buoy is reporting, or the URL/format has changed. Check '
            'https://www.ndbc.noaa.gov/data/realtime2/44013.txt manually.',
          );
        }
        expect(r.source, DataSource.noaaNdbc);
        expect(
          r.value,
          inInclusiveRange(28, 85),
          reason: 'NE-US sea surface temps span ~30°F (winter) to ~80°F '
              '(late summer). Value outside that range likely means a unit-'
              'conversion regression.',
        );
        expect(r.unit, 'F');
        expect(r.confidence, greaterThan(0));
      },
      tags: ['live'],
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'getTideState returns a real tide phase for Boston Harbor',
      () async {
        final r = await service.getTideState(
          bostonHarbor,
          DateTime.now().toUtc(),
        );
        if (r.source == DataSource.unavailable) {
          fail(
            'Tides & Currents returned unavailable. Check '
            'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter manually.',
          );
        }
        expect(r.source, DataSource.noaaTidesAndCurrents);
        expect(r.value.toNextChange, isNot(Duration.zero));
      },
      tags: ['live'],
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'getWind returns a real WindVector via NWS',
      () async {
        final r = await service.getWind(bostonHarbor, DateTime.now().toUtc());
        if (r.source == DataSource.unavailable) {
          // NWS sometimes returns empty / inconsistent forecasts for
          // marine-adjacent grids; a fail here means we should investigate.
          fail('Wind returned unavailable. Check api.weather.gov manually.');
        }
        expect(
          r.source,
          anyOf(
            DataSource.noaaMarineForecast,
            DataSource.noaaNdbc,
          ),
        );
        expect(r.value.speedKnots, inInclusiveRange(0, 80));
        expect(r.value.directionDegrees, inInclusiveRange(0, 360));
      },
      tags: ['live'],
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'getSolunar always returns (pure local — sanity check)',
      () async {
        final r = await service.getSolunar(
          bostonHarbor,
          DateTime.now().toUtc(),
        );
        expect(r.source, DataSource.computedLocal);
        expect(r.confidence, 1);
      },
    );
  });
}
