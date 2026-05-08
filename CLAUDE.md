# Project context for Claude

This file is auto-loaded by Claude Code at session start. Keep it dense and current; it's the primary handoff between sessions and machines.

## What this is

AI Marine Recommendation Engine — a Flutter app that gives Florida saltwater anglers per-spot fishing-condition scores with a transparent breakdown of why a spot is good. Pivoted from a Northeast striper concept earlier in 2026.

- **Source of truth**: the authoritative `.docx` specs live in the parent directory (TDD wins on conflicts), not `docs/`
- **Defensibility**: every score is decomposed into gates / modifiers / contributors / math — the user can always see why
- **Repo**: `C:\dev\ai_marine_engine` (Windows) or `~/dev/ai_marine_engine` (Mac/Linux). **Never** put it under OneDrive — Gradle and `flutter clean` lose to OneDrive sync constantly. Project moved off OneDrive 2026-05-05.

## Current state (commit `b4a5678`, end of slice 13a.2 + station pivot)

**Works in the running app today:**

- Marine chart: Esri World Ocean Base + Esri Ocean Reference (depth labels) + OpenSeaMap seamarks, centred on Tampa Bay; camera animates to first GPS fix
- Buoy markers (~163 NDBC stations): tap → live observation card (wind / temp / waves / pressure)
- Wreck markers (~20 OSM `seamark:type=wreck` features, filtered to those tagged with category or depth): tap → info card
- Open-water tap → `scoreAtLocationProvider` → full recommendation card (gates + modifiers + contributors + math + suggested approach)
- Species picker chip top-left of the chart
- "Plan trip" pill top-right launches `PlanTripScreen`: 4-step wizard (NDBC station → time window → species → review) → saves a `TripPlan` and sets it as the active trip. Chart doesn't yet visually react to the active trip.

**Test count: 513 passing, format + analyze clean.**

## Slice plan (where to pick up)

Phase 7 trip-planning sequence:

| Slice | Status | Scope |
|---|---|---|
| 13a.1 | ✅ done | `TripPlan` value type + `TripPlansRepository` + providers |
| 13a.2 | ✅ done | "Plan trip" UI flow (custom stepper, NDBC station anchor) |
| **13b** | **next** | Tile downloader: walk z8–z15 across trip bbox, persist tiles to filesystem |
| 13c | pending | maplibre offline tile source: read cached tiles, fall back to live |
| 13d | pending | Score-grid pre-compute for trip bbox at 0.6 nm resolution (streaming: coarse first, refine in background) |
| 13e | pending | Connectivity awareness + offline badges + cache TTL |
| 13f | pending | Active-trip visual on chart + saved-trips library + cache eviction |

**Deferred:**
- Heatmap layer (will look better once trip-area filtering declutters the chart)
- Top-N pin markers
- NOAA MBTiles bundling (their RNC tile API retired Jan 2026, but they still distribute weekly-updated MBTiles for offline use; ~200–500 MB per FL region — v1.5+ feature)
- Boat ramp data — was tried (slice 12c) and removed because OSM `leisure=slipway` has too much inland-water noise. Bring it back later only with an authoritative FWC dataset or a working coastline-proximity Overpass filter.

## Decisions worth remembering

- **Trip anchor = NDBC station** (not boat ramp). 163 curated saltwater-only stations beat 2k+ noisy OSM ramps. Persisted in `TripCacheStatus.stationId`.
- **Default trip area** = 15 nm bbox around the chosen station (`LatLngBounds.fromCenter` with cosine-corrected longitude extent). User-adjustable via bbox drag in slice 13a.3 (deferred).
- **Marine theme is dark-first, Material 3.** `Stepper` and several other M3 widgets render invisibly on `surface = deepMarine`. Use custom layouts. `PlanTripScreen` has the canonical custom-stepper pattern.
- **Marine theme `ElevatedButton.minimumSize = Size.fromHeight(48)`** — full-width by default. Inline buttons in a `Row` need `style: ElevatedButton.styleFrom(minimumSize: Size(120, 44))` override or layout fails with `BoxConstraints(unconstrained)`.
- **`flutter run` over OneDrive paths is forbidden.** Already moved; never let it happen again.
- **CI runs `dart format --set-exit-if-changed .`** — local format must use `.`, not subpaths. A 4-push streak failed because subpath format runs missed a real diff.

## Build workflow (mirror CI before every commit)

```bash
fvm dart format --set-exit-if-changed .
fvm flutter analyze --fatal-infos
fvm flutter test
```

After modifying any `@freezed` / `@JsonSerializable` source, regenerate via the snapshot to sidestep the Dart 3.4 pub-advisories null-check bug:

```bash
fvm dart .dart_tool/build/entrypoint/build.dart build --delete-conflicting-outputs
```

(Once Dart SDK upgrades past the advisories bug, the canonical `fvm dart run build_runner build --delete-conflicting-outputs` works again.)

Drift integration tests skip on Windows hosts without `sqlite3.dll` (the `_helpers/sqlite3_setup.dart` skips with a reason). They run cleanly on Mac and Linux CI.

## Mac setup

```bash
brew install fvm
git clone https://github.com/pjaelmore/AI-Marine.git ~/dev/ai_marine_engine
cd ~/dev/ai_marine_engine
fvm flutter pub get
open -a Simulator
fvm flutter run
```

Before first iOS run, verify:
- `ios/Runner/Info.plist` has `NSLocationWhenInUseUsageDescription` (geolocator crashes without it)
- `ios/Podfile` sets `platform :ios, '12.0'` or higher (maplibre_gl 0.20 floor)

Mac is materially better for dev: iOS Simulator beats Android emulator on cold start, no ADB daemon shenanigans, integration tests run locally.

## Tone & code conventions

- Default to no comments. Only add a comment when the *why* is non-obvious — a hidden constraint, a workaround, a trap. Don't narrate the *what* (well-named identifiers do that). Don't reference the current task or PR (commit messages do that).
- Don't add error handling for impossible scenarios. Validate at system boundaries; trust internal code.
- Don't pre-emptively wire UI scaffolding into the running app. Build slice → land via a focused commit → user sees it next hot-restart. The user has rejected "preview" wiring before because it duplicates work that the real wiring (later slice) replaces.
- Slices ship one focused change at a time. Naming: `phase X: description (slice Y[a/b/c])`. Each slice has its own commit + push + green-CI confirmation before the next starts.

## Pointers

- **Spec docs** live in the parent directory as `.docx`. Read those if architecture clarification is needed.
- **ADRs** in `docs/adr/`.
- **Living progress notes**: this file. Update at end of each session.
- **GitHub remote**: `https://github.com/pjaelmore/AI-Marine.git` (main is the only branch in active use).

---

_Last updated: end of session that pivoted trip planner from OSM boat ramps to NDBC stations. Commit_ `b4a5678`.
