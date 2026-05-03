import 'dart:io';

import 'package:ai_marine_engine/data/sources/tides_currents/tide_prediction.dart';
import 'package:ai_marine_engine/data/sources/tides_currents/tides_currents_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseTidePredictions', () {
    test('extracts every prediction row from the real Boston fixture', () {
      // Captured live from
      //   https://api.tidesandcurrents.noaa.gov/api/prod/datagetter
      //   ?product=predictions&station=8443970&begin_date=20260504&...
      // on 2026-05-04. First row reads 05:24 UTC, 10.053 ft, type H.
      final body = File(
        'test/fixtures/http_responses/tides_8443970.json',
      ).readAsStringSync();

      final preds = parseTidePredictions(body);

      expect(preds, hasLength(7));
      expect(preds.first.time, DateTime.utc(2026, 5, 4, 5, 24));
      expect(preds.first.heightFt, closeTo(10.053, 1e-9));
      expect(preds.first.type, TideType.high);
      expect(preds[1].type, TideType.low);
      expect(preds.last.time, DateTime.utc(2026, 5, 5, 18, 44));
    });

    test('throws FormatException on a body missing the predictions key', () {
      const body = '{"error": {"message": "no station found"}}';
      expect(
        () => parseTidePredictions(body),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws FormatException on rows missing fields', () {
      const body = '{"predictions": [{"t": "2026-05-04 05:24"}]}';
      expect(
        () => parseTidePredictions(body),
        throwsA(isA<FormatException>()),
      );
    });

    test('parses timestamps as UTC because we request time_zone=GMT', () {
      const body =
          '{"predictions":[{"t":"2026-05-04 05:24","v":"10.0","type":"H"}]}';
      final pred = parseTidePredictions(body).single;
      expect(pred.time.isUtc, isTrue);
      expect(pred.time.hour, 5);
    });
  });
}
