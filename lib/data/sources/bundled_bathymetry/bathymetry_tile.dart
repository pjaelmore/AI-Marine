import 'dart:typed_data';

/// One decoded 1°×1° bathymetry tile.
///
/// **Binary layout** (little-endian, produced by
/// `scripts/build_fl_bathymetry.dart`):
///
/// ```
/// off  type   field
/// 0    u32    magic = 0x54424C46  ('FLBT')
/// 4    u16    version = 1
/// 6    u16    cellsPerSide  (e.g. 1200 for 3 arc-sec over 1°)
/// 8    f64    swLat   (south edge, integer degree)
/// 16   f64    swLon   (west edge,  integer degree)
/// 24   f64    cellSizeDeg
/// 32   i16    nodata sentinel
/// 34   i16[]  data, row-major, **row 0 = NORTH edge** going south;
///             metres relative to mean sea level (negative = depth)
/// ```
///
/// Row 0 being the north edge matches the ESRI-ASCII / GMRT grid
/// convention the build script consumes, so the script can stream
/// rows straight through without flipping.
class BathymetryTile {
  BathymetryTile._({
    required this.cellsPerSide,
    required this.swLat,
    required this.swLon,
    required this.cellSizeDeg,
    required this.nodata,
    required Int16List data,
  }) : _data = data;

  static const int magic = 0x54424C46; // 'FLBT'
  static const int headerBytes = 34;

  final int cellsPerSide;
  final double swLat;
  final double swLon;
  final double cellSizeDeg;
  final int nodata;
  final Int16List _data;

  /// Parses a decompressed tile blob. Throws [FormatException] on a
  /// bad magic / version / truncated body so a corrupt asset surfaces
  /// loudly rather than returning garbage depths.
  factory BathymetryTile.parse(Uint8List bytes) {
    if (bytes.length < headerBytes) {
      throw const FormatException('Bathymetry tile shorter than header');
    }
    final bd = ByteData.sublistView(bytes);
    final m = bd.getUint32(0, Endian.little);
    if (m != magic) {
      throw FormatException(
        'Bad bathymetry tile magic: '
        '0x${m.toRadixString(16)} (expected 0x${magic.toRadixString(16)})',
      );
    }
    final version = bd.getUint16(4, Endian.little);
    if (version != 1) {
      throw FormatException('Unsupported bathymetry tile version $version');
    }
    final side = bd.getUint16(6, Endian.little);
    final swLat = bd.getFloat64(8, Endian.little);
    final swLon = bd.getFloat64(16, Endian.little);
    final cell = bd.getFloat64(24, Endian.little);
    final nodata = bd.getInt16(32, Endian.little);

    final expectedCells = side * side;
    final expectedBytes = headerBytes + expectedCells * 2;
    if (bytes.length < expectedBytes) {
      throw FormatException(
        'Bathymetry tile body truncated: got ${bytes.length} bytes, '
        'expected $expectedBytes for $side×$side',
      );
    }
    // View the int16 grid directly off the same buffer — no copy.
    final data = Int16List.sublistView(bytes, headerBytes, expectedBytes);
    return BathymetryTile._(
      cellsPerSide: side,
      swLat: swLat,
      swLon: swLon,
      cellSizeDeg: cell,
      nodata: nodata,
      data: data,
    );
  }

  /// Whether [lat]/[lon] falls inside this tile's 1° footprint.
  bool covers(double lat, double lon) {
    final span = cellSizeDeg * cellsPerSide;
    return lat >= swLat &&
        lat < swLat + span &&
        lon >= swLon &&
        lon < swLon + span;
  }

  /// Depth in **feet** at [lat]/[lon], or null when the cell is
  /// NODATA (no survey coverage) or on land (elevation ≥ 0). Callers
  /// translate null into a `SourceException` so the conditions service
  /// can fall through to GEBCO.
  double? depthFtAt(double lat, double lon) {
    final col = ((lon - swLon) / cellSizeDeg).floor();
    // Row 0 is the north edge; latitude decreases as the row index
    // grows, so measure down from the north edge.
    final northLat = swLat + cellSizeDeg * cellsPerSide;
    final row = ((northLat - lat) / cellSizeDeg).floor();
    if (col < 0 || col >= cellsPerSide || row < 0 || row >= cellsPerSide) {
      return null;
    }
    final v = _data[row * cellsPerSide + col];
    if (v == nodata) return null;
    if (v >= 0) return null; // land / above sea level
    return -v * 3.28084; // metres below sea level → feet of water
  }
}
