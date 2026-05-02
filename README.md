# AI Marine Recommendation Engine

Transparent, on-device fishing recommendations for recreational saltwater anglers.
v1.0 targets striped bass in the Northeast US (MA / RI / CT / NY).

## Spec documents

Authoritative design lives one directory up:

- `../AI_Marine_Recommendation_Engine_Framework.docx` — architectural principles, scoring methodology
- `../AI_Marine_TDD_v1.0_Complete.docx` — technical design, data models, API integrations
- `../AI_Marine_Implementation_Guide.docx` — phased build plan, per-component DoD

When the framework and TDD conflict, the **TDD is authoritative for implementation**.

## Stack

- **Flutter 3.22.0** (pinned via FVM — see `.fvmrc`)
- **Riverpod 2.x** (`flutter_riverpod`, `riverpod_generator`)
- **Drift 2.x** (SQLite ORM with code generation)
- **Dio** (HTTP with retry interceptors)
- **MapLibre GL** (NOAA ENC tile rendering)
- **Supabase** (provisioned in v1; sync deferred to v1.5+)
- **Sentry** (crash + performance reporting)
- **Freezed / json_serializable** (value types + serialization)

## Local development

This project uses [FVM](https://fvm.app) to pin Flutter 3.22.0.

```bash
# First time on this machine — install Flutter 3.22.0 into FVM's cache
fvm install 3.22.0

# Inside this directory, all Flutter commands go through FVM
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run
```

If you prefer not to type `fvm` each time, add `.fvm/flutter_sdk/bin` to your shell PATH **inside this project only** — direnv or a project-local `.envrc` works well.

### Supabase

The Postgres backend is **provisioned in v1 but not integrated from the app** until v1.5+ when sync ships (TDD §4.3). The schema lives in `supabase/migrations/` as plain SQL.

To apply it to a project:

```bash
# One-time, on this machine:
supabase login
supabase init                # creates supabase/config.toml — commit if you want
supabase link --project-ref <your-ref>

# Apply migrations:
supabase db push
```

For local-only iteration without a hosted project: `supabase start` (boots a local Postgres + Studio in Docker) then `supabase db reset` to apply migrations to the local instance. RLS policies require the `auth` schema, which `supabase start` includes by default.

### Sentry DSN

The DSN is read at build time from a `--dart-define`. Empty DSN = SDK no-ops, so the app runs fine without one in dev:

```bash
fvm flutter run --dart-define=SENTRY_DSN=https://<your-key>@o<org>.ingest.sentry.io/<project>
```

To confirm the pipeline end-to-end after first install, call `triggerSentryTestEvent()` (in `lib/core/logging/sentry_setup.dart`) from a debug build and look for the event in your Sentry dashboard. Lat/lon attached as Sentry extras are rounded to 0.1° (~11 km) in `beforeSend`; common identifier-shaped keys (`email`, `userId`, `device_id`, `notes`, …) are dropped entirely.

## Project structure

Per Implementation Guide §1.3:

```
lib/
├── core/         # types, errors, utils, logging
├── data/
│   ├── database/   # Drift tables + DAOs + migrations
│   ├── species/    # bundled species records
│   ├── sources/    # one folder per external API (NDBC, tides, NWS, ENC, solunar)
│   └── cache/      # 4-layer cache implementation
├── services/
│   ├── conditions/    # unified data layer
│   ├── calculator/    # 3-layer scoring engine (gates / modifiers / contributors)
│   ├── catch_log/
│   └── connectivity/
├── state/        # Riverpod providers grouped by purpose
├── ui/
│   ├── design/, chart/, recommendation_card/, catch_log/, pre_trip/, settings/
│   └── helm_mode/  # Phase 2
└── platform/
    ├── gps/
    └── ble/      # Phase 2 (NMEA 2000)

test/
├── unit/         # mirrors lib/
├── integration/
├── calibration/  # 50-tuple regression suite (CI hard-fail)
├── widget/
└── fixtures/

integration_test/   # E2E flows
```

## Build / Run

| Target  | Command                                         | Notes                  |
|---------|-------------------------------------------------|------------------------|
| Android | `fvm flutter build apk --debug`                | Local, requires Android SDK |
| iOS     | Codemagic / build on Mac                        | No Xcode on Windows    |
| Test    | `fvm flutter test`                              | Unit + widget          |
| Lint    | `fvm flutter analyze`                           | Strict — see `analysis_options.yaml` |

## Phase status

- [x] **Phase 1** — scaffold (in progress)
- [ ] Phase 2 — core types + database
- [ ] Phase 3 — data sources
- [ ] Phase 4 — cache layer
- [ ] Phase 5 — probability calculator
- [ ] Phase 6 — chart UI + recommendation card
- [ ] Phase 7 — catch log + pre-trip planner
- [ ] Phase 8 — polish + ship
