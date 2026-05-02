import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Dev marine chart style asset — see ADR 0002', () {
    late Map<String, dynamic> style;
    late Map<String, dynamic> sources;
    late List<Map<String, dynamic>> layers;

    setUpAll(() async {
      final raw = await rootBundle.loadString(
        'assets/map_styles/marine_chart_dev.json',
      );
      style = jsonDecode(raw) as Map<String, dynamic>;
      sources = style['sources'] as Map<String, dynamic>;
      layers = (style['layers'] as List).cast<Map<String, dynamic>>();
    });

    test('declares MapLibre style version 8', () {
      expect(style['version'], 8);
    });

    test('exposes OSM base raster source on the canonical XYZ template', () {
      final src = sources['osm'] as Map<String, dynamic>;
      expect(src['type'], 'raster');
      expect(src['tileSize'], 256);
      final tiles = (src['tiles'] as List).cast<String>();
      expect(tiles, hasLength(1));
      expect(tiles.first, 'https://tile.openstreetmap.org/{z}/{x}/{y}.png');
      expect(src['attribution'], contains('OpenStreetMap'));
    });

    test('exposes the OpenSeaMap nautical overlay raster source', () {
      final src = sources['openseamap'] as Map<String, dynamic>;
      expect(src['type'], 'raster');
      expect(src['tileSize'], 256);
      final tiles = (src['tiles'] as List).cast<String>();
      expect(
        tiles.first,
        'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
      );
      expect(src['attribution'], contains('OpenSeaMap'));
    });

    test('background layer uses the deep-marine palette color', () {
      final bg = layers.firstWhere((l) => l['id'] == 'background');
      expect(bg['type'], 'background');
      final paint = bg['paint'] as Map<String, dynamic>;
      expect((paint['background-color'] as String).toUpperCase(), '#0F2A47');
    });

    test('layers stack background → OSM base → OpenSeaMap overlay', () {
      // Order matters: nautical seamarks must paint *over* the OSM base.
      final ids = layers.map((l) => l['id']).toList();
      expect(ids, ['background', 'osm-base', 'openseamap-overlay']);
      expect(layers[1]['source'], 'osm');
      expect(layers[2]['source'], 'openseamap');
    });
  });
}
