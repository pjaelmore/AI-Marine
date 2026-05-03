import 'dart:io';

import 'package:ai_marine_engine/data/sources/ndbc/ndbc_parser.dart';
import 'package:flutter_test/flutter_test.dart';

String _loadFixture(String relativePath) {
  // flutter test runs with the project root as CWD.
  final file = File('test/fixtures/http_responses/$relativePath');
  return file.readAsStringSync();
}

void main() {
  group('parseLatestNdbc', () {
    test('extracts the latest observation from a real NDBC fixture', () {
      // Captured live from https://www.ndbc.noaa.gov/data/realtime2/44013.txt
      // on 2026-05-03; first observation row reads:
      //   2026 05 03 12 00  WDIR=320 WSPD=7.0 GST=8.0 PRES=1006.1
      //   ATMP=7.0 WTMP=8.3
      // Wave columns are MM (missing) for that row.
      final body = _loadFixture('ndbc_44013.txt');
      final obs = parseLatestNdbc(body, '44013');

      expect(obs.stationId, '44013');
      expect(obs.timestamp, DateTime.utc(2026, 5, 3, 12));
      expect(obs.windDirDegT, 320);
      expect(obs.windSpeedMps, closeTo(7.0, 1e-9));
      expect(obs.gustMps, closeTo(8.0, 1e-9));
      expect(obs.pressureHpa, closeTo(1006.1, 1e-9));
      expect(obs.airTempC, closeTo(7.0, 1e-9));
      expect(obs.waterTempC, closeTo(8.3, 1e-9));
      // Wave height / dominant period are MM in this row.
      expect(obs.waveHeightM, isNull);
      expect(obs.dominantPeriodSec, isNull);
    });

    test("'MM' tokens parse to null on every column", () {
      const body = '#YY MM DD hh mm WDIR WSPD GST WVHT DPD APD MWD '
          'PRES ATMP WTMP DEWP VIS PTDY TIDE\n'
          '#yr mo dy hr mn degT m/s m/s m sec sec degT hPa '
          'degC degC degC nmi hPa ft\n'
          '2026 05 03 12 00 MM MM MM MM MM MM MM MM MM MM MM MM MM MM\n';
      final obs = parseLatestNdbc(body, '44013');
      expect(obs.windDirDegT, isNull);
      expect(obs.windSpeedMps, isNull);
      expect(obs.gustMps, isNull);
      expect(obs.waveHeightM, isNull);
      expect(obs.dominantPeriodSec, isNull);
      expect(obs.pressureHpa, isNull);
      expect(obs.airTempC, isNull);
      expect(obs.waterTempC, isNull);
    });

    test('throws FormatException on a body with no observation rows', () {
      const headerOnly =
          '#YY MM DD hh mm WDIR WSPD\n#yr mo dy hr mn degT m/s\n';
      expect(
        () => parseLatestNdbc(headerOnly, '44013'),
        throwsA(isA<FormatException>()),
      );
    });

    test('returns null for any column missing from a truncated row', () {
      // Only the timestamp prefix; everything past that is absent.
      const body = '#YY MM DD hh mm\n#yr mo dy hr mn\n2026 05 03 12 00\n';
      final obs = parseLatestNdbc(body, '44013');
      expect(obs.timestamp, DateTime.utc(2026, 5, 3, 12));
      expect(obs.waterTempC, isNull);
      expect(obs.pressureHpa, isNull);
    });
  });
}
