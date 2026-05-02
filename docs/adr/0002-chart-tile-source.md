# ADR 0002 — Chart tile source: OpenStreetMap + OpenSeaMap (dev), MBTiles (production)

**Status:** Accepted
**Date:** 2026-05-02
**Phase:** 1 (Project Scaffolding)
**Supersedes:** TDD §5.5.2 tile endpoint

## Context

TDD §5.5.1 specifies the NOAA ENC tile endpoint:

```
GET https://gis.charttools.noaa.gov/arcgis/rest/services/MCS/ENCOnline/MapServer/tile/{z}/{y}/{x}
```

When this URL was first integrated for Phase 1, every tile request returned HTTP 404. The cause is upstream: **NOAA shut down their public XYZ tile service on October 1, 2021**, and the TDD was written against an endpoint that has not been functional for years. NOAA's announcement: <https://nauticalcharts.noaa.gov/updates/coast-survey-launches-noaa-chart-display-service/>.

NOAA's current public offerings, evaluated:

| Service | Format | Verified status | Notes |
|---|---|---|---|
| Old ENC Online tile cache (TDD spec) | XYZ raster | **404 — dead** | service descriptor returns degenerate fields (empty `name`, `NaN` extent); no tiles served |
| Marine Chart Services WMTS at `gis.charttools.noaa.gov/.../MarineChart_Services/NOAACharts/MapServer/WMTS` | WMTS raster | **Empty in `GoogleMapsCompatible`** | tested zoom 0–8 around Boston Harbor; all 200 OK but each response is a 177-byte placeholder PNG with no chart imagery |
| OGC WMS at the same host | Server-rendered raster | Functional | high latency (rendered on demand); not tile-cached; unsuitable for interactive chart UX |
| MBTiles via `distribution.charts.noaa.gov/ncds/` | Offline SQLite-packed tiles | Functional | NOAA-authoritative; gigabyte-scale; refreshed monthly; bundled or downloaded once per region |

So the spec endpoint is dead, the WMTS replacement is empty, WMS is too slow for live pan/zoom, and MBTiles is the only NOAA-authoritative path that gives us interactive performance.

## Decision

A two-stage approach:

**Phase 1–3 (development):** Use **OpenStreetMap base + OpenSeaMap nautical overlay** as the chart tile source.

- Base: `https://tile.openstreetmap.org/{z}/{x}/{y}.png`
- Overlay: `https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png`
- Style asset: `assets/map_styles/marine_chart_dev.json`

This unblocks Phase 1 visual verification today and lets Phases 2, 3, and 5 use a working chart while engine and data-source work proceeds.

**Phase 4 (cache layer):** Switch the production tile source to **NOAA MBTiles** as part of the offline-first cache work specified in TDD §5.5.3 and §10.4 (Pre-Trip Planner). MBTiles fits the offline architecture naturally — the chart_tile_cache table from §4.1.4 maps directly onto MBTiles' z/x/y/blob structure.

## Consequences

### Positive

- Phase 1 deliverable (Implementation Guide §2.2.3 — "shows your boat ramp on a NOAA chart") is reachable today rather than blocked on architecture work that belongs to a later phase.
- OpenSeaMap renders real nautical features (buoys, depth contours, shipping lanes, lights) so the dev chart isn't a meaningless background — engine output overlays will be visible against actual marine context during development.
- MBTiles in Phase 4 is the right long-term answer regardless of NOAA's tile service status, because v1's offline-first design needs locally-stored chart data anyway. This decision pulls forward a problem we'd have hit later.
- No dependency on NOAA's ArcGIS service uptime during development.

### Negative / risks

- **OSM tile usage policy.** OSM's standard tile server is not for production-scale traffic. Heavy fetching in production builds would warrant a paid tile provider (Mapbox, MapTiler, Stadia, Thunderforest), self-hosting, or — preferred — moving up the MBTiles work. For solo dev plus a small TestFlight beta this is fine; revisit before public launch.
- **Not NOAA-authoritative for development.** OpenSeaMap is community-maintained. Buoy positions, depth contours, and channel markers are accurate enough for orientation but cannot be relied on for navigation. The app's positioning of recommendations in dev builds is therefore not legally a navigational aid — but v1 was never going to be one regardless.
- **Two style files in the codebase eventually.** Phase 4 introduces a production style backed by MBTiles; the dev style stays for emulator and local testing. Manageable; one switch in `MarineChartView`.

### Out of scope (deliberately)

- Falling back to NOAA WMS for development. Tested mentally and rejected: server-rendered WMS GetMap requests at slippy-tile pace would saturate latency and put load on a public NOAA endpoint. WMS is right for occasional fetches, wrong for interactive pan/zoom.
- Bundling NOAA MBTiles in the v1 APK. The full set is multi-GB and Play Store / App Store have package size limits. Phase 4's plan is download-on-first-use with regional pinning, which sidesteps this.
- A pluggable tile-source registry. We have exactly two sources (dev and Phase 4 MBTiles) and one switch. Building an abstraction now would be premature.

## Implementation notes

- Style file: `assets/map_styles/marine_chart_dev.json` (was `noaa_enc.json` until this ADR).
- `MarineChartView._defaultStyleAsset` points at the dev style.
- `noaa_enc_style_test.dart` was replaced by `marine_chart_style_test.dart`; tests pin the URL templates, layer order, and OpenSeaMap overlay above the OSM base.
- Phase 4 work tracker: introduce `MbTilesSourceAdapter` under `lib/data/sources/enc_tiles/`, register it in the cache manager, swap `MarineChartView._defaultStyleAsset` to a production style backed by `mbtiles://` URIs (or equivalent — exact mechanism TBD when we get there).
