# ADR 0001 — Use `gen_random_uuid()` for Supabase UUID defaults

**Status:** Accepted
**Date:** 2026-05-02
**Phase:** 1 (Project Scaffolding)

## Context

TDD §4.2.1 specifies the Supabase Postgres schema bootstrap as:

```sql
create extension if not exists postgis;
create extension if not exists "uuid-ossp";
```

…and §4.2.2 uses `uuid_generate_v4()` from the `uuid-ossp` extension as the default for `app.catches.id`.

When the v1 migration was first applied via `supabase db push`, statement-3 failed:

```
NOTICE: extension "uuid-ossp" already exists, skipping
ERROR:  function uuid_generate_v4() does not exist (SQLSTATE 42883)
```

Supabase preinstalls `uuid-ossp` into the `extensions` schema. Connections default to a `search_path` of `"$user", public`, which does not include `extensions`. Objects created in our `app` schema therefore cannot resolve unqualified `uuid_generate_v4()`. Three options:

1. Qualify every call: `extensions.uuid_generate_v4()`.
2. Set a `search_path` on the role or per-database that includes `extensions`.
3. Use `gen_random_uuid()` — a Postgres 13+ core built-in that produces a v4 UUID with no extension needed.

## Decision

Use **option 3**: `gen_random_uuid()`. Drop the `create extension "uuid-ossp"` line entirely; no replacement extension is required.

## Consequences

- v1 migration applies cleanly to a fresh Supabase project with no manual setup.
- Behaviour is identical at the row level: both functions emit a v4 UUID, and both produce a 36-character string when cast to text.
- The on-device SQLite schema (TDD §4.1) generates UUIDs in Dart (`uuid` package) before insert, so this server-side change has no effect on local-record IDs once sync ships in v1.5+.
- This is a Supabase-specific accommodation; the framework-level intent (server-generated v4 UUIDs as the row identifier) is preserved. If we ever migrate off Supabase to vanilla Postgres ≥ 13, no further change is needed; on Postgres < 13 we would need to revisit.
- Supabase officially documents `gen_random_uuid()` as the preferred default, so this aligns the project with the platform's own recommendation rather than the legacy `uuid-ossp` path.
