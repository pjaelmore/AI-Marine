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

    test('exposes Esri World Ocean Base as the basemap raster source', () {
      // Esri ArcGIS REST tile URLs expect {z}/{y}/{x} order — not the
      // canonical OSM {z}/{x}/{y}. maplibre substitutes both correctly
      // from the tile coords; the URL template just needs the right
      // placeholder positions for the upstream server.
      final src = sources['esri-ocean'] as Map<String, dynamic>;
      expect(src['type'], 'raster');
      expect(src['tileSize'], 256);
      final tiles = (src['tiles'] as List).cast<String>();
      expect(tiles, hasLength(1));
      expect(
        tiles.first,
        'https://services.arcgisonline.com/arcgis/rest/services/Ocean/World_Ocean_Base/MapServer/tile/{z}/{y}/{x}',
      );
      // Esri's terms require attribution to Esri and the upstream
      // contributors — see https://www.esri.com/en-us/legal/terms.
      expect(src['attribution'], contains('Esri'));
    });

    test('exposes Esri World Ocean Reference as a labelled overlay source', () {
      // Reference layer adds depth labels + sea-floor feature names on
      // top of the bathymetry shading from World_Ocean_Base. Same
      // ArcGIS {z}/{y}/{x} order as the base layer.
      final src = sources['esri-ocean-reference'] as Map<String, dynamic>;
      expect(src['type'], 'raster');
      expect(src['tileSize'], 256);
      final tiles = (src['tiles'] as List).cast<String>();
      expect(
        tiles.first,
        'https://services.arcgisonline.com/arcgis/rest/services/Ocean/World_Ocean_Reference/MapServer/tile/{z}/{y}/{x}',
      );
      expect(src['attribution'], contains('Esri'));
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

    test(
      'layers stack background → ocean base → ocean reference → seamarks',
      () {
        // Order matters: depth labels + feature names paint above the
        // bathymetry shading; seamarks (channel markers, lights) paint
        // above the labels so navigational symbols stay legible.
        final ids = layers.map((l) => l['id']).toList();
        expect(ids, [
          'background',
          'esri-ocean-base',
          'esri-ocean-reference-overlay',
          'openseamap-overlay',
        ]);
        expect(layers[1]['source'], 'esri-ocean');
        expect(layers[2]['source'], 'esri-ocean-reference');
        expect(layers[3]['source'], 'openseamap');
      },
    );
  });
}
