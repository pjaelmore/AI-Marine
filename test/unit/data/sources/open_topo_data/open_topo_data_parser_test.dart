import 'package:ai_marine_engine/data/sources/open_topo_data/open_topo_data_parser.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _body({
  required num? elevation,
  String status = 'OK',
  bool emptyResults = false,
}) {
  return {
    'status': status,
    'results': emptyResults
        ? <Map<String, dynamic>>[]
        : [
            {
              'elevation': elevation,
              'location': {'lat': 28.5, 'lng': -80.0},
              'dataset': 'gebco2020',
            },
          ],
  };
}

void main() {
  group('parseOpenTopoDataDepth', () {
    test('ocean reading (negative metres) is converted to positive feet', () {
      // -45 m → 45 m depth → 147.638 ft
      final r = parseOpenTopoDataDepth(_body(elevation: -45));
      expect(r.isLand, isFalse);
      expect(r.depthFt, closeTo(147.638, 1e-3));
    });

    test('land reading (positive metres) returns isLand = true', () {
      final r = parseOpenTopoDataDepth(_body(elevation: 12.5));
      expect(r.isLand, isTrue);
      expect(r.depthFt, 0);
    });

    test(
        'exactly zero elevation is treated as land — '
        'no usable depth at the waterline', () {
      // Treating 0 as land is conservative; "fishing in 0 feet of
      // water" makes no sense and most barrier-island queries snap to
      // 0 due to GEBCO's 450 m grid.
      final r = parseOpenTopoDataDepth(_body(elevation: 0));
      expect(r.isLand, isTrue);
    });

    test('null elevation (outside coverage) is treated as land', () {
      final r = parseOpenTopoDataDepth(_body(elevation: null));
      expect(r.isLand, isTrue);
    });

    test('non-OK status throws FormatException', () {
      expect(
        () => parseOpenTopoDataDepth(
          _body(elevation: -45, status: 'INVALID_REQUEST'),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('empty results array throws FormatException', () {
      expect(
        () => parseOpenTopoDataDepth(_body(elevation: 0, emptyResults: true)),
        throwsA(isA<FormatException>()),
      );
    });

    test('missing results key throws FormatException', () {
      expect(
        () => parseOpenTopoDataDepth({'status': 'OK'}),
        throwsA(isA<FormatException>()),
      );
    });

    test('non-numeric elevation throws FormatException', () {
      expect(
        () => parseOpenTopoDataDepth({
          'status': 'OK',
          'results': [
            {'elevation': 'not a number'},
          ],
        }),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
