-- AI Marine Engine — initial Supabase schema
-- Source: TDD v1.0 §4.2 (Supabase Postgres Schema).
--
-- The Postgres backend is provisioned in v1 but not integrated from the app
-- until v1.5+ when bidirectional sync ships (TDD §4.3). For v1 the on-device
-- SQLite database (TDD §4.1, Drift-managed) is the system of record.
--
-- Apply with:  supabase db push  (after `supabase link` to your project).

-- ── §4.2.1 Setup ─────────────────────────────────────────────────────────
-- DEVIATION from TDD §4.2.1: dropped `create extension "uuid-ossp"` and
-- switched the catches.id default to `gen_random_uuid()` (Postgres 13+
-- built-in). On Supabase, uuid-ossp is preinstalled into the `extensions`
-- schema and is not on the search_path of objects in `app`, so the spec's
-- `uuid_generate_v4()` call fails to resolve. See docs/adr/0001-supabase-uuid-default.md.
create extension if not exists postgis;
create schema if not exists app;

-- ── §4.2.2 catches ───────────────────────────────────────────────────────
create table app.catches (
  id                       uuid primary key default gen_random_uuid(),
  user_id                  uuid not null references auth.users(id) on delete cascade,
  timestamp_utc            timestamptz not null,
  location                 geography(point, 4326) not null,
  location_source          text not null check (
    location_source in ('phone_gps', 'nmea_2000', 'manual', 'last_known')
  ),
  species_id               text not null,
  size_class_id            text,
  length_inches            numeric(6, 2),
  weight_pounds            numeric(7, 2),
  bait_or_lure             text,
  released                 boolean,
  notes                    text,
  photo_storage_key        text,
  recommendation_pin_id    text,
  conditions               jsonb not null,
  engine_score_at_catch    numeric(4, 2),
  engine_reasoning         jsonb,
  created_at_utc           timestamptz not null default now(),
  updated_at_utc           timestamptz not null default now(),
  client_id                text not null,
  client_version           text not null
);

create index idx_catches_user_time
  on app.catches (user_id, timestamp_utc desc);

create index idx_catches_location
  on app.catches using gist (location);

create unique index idx_catches_client_id
  on app.catches (user_id, client_id);

-- ── §4.2.3 Row-Level Security ────────────────────────────────────────────
-- Every row is scoped to its owning user; users can never read or write
-- another user's catches. Policy enforcement happens in Postgres so even a
-- compromised client key cannot exfiltrate other users' data.
alter table app.catches enable row level security;

create policy catches_user_select on app.catches
  for select using (auth.uid() = user_id);

create policy catches_user_insert on app.catches
  for insert with check (auth.uid() = user_id);

create policy catches_user_update on app.catches
  for update using (auth.uid() = user_id);

create policy catches_user_delete on app.catches
  for delete using (auth.uid() = user_id);

-- §4.2.4 (catches_aggregate view) is deferred — it depends on an
-- app.user_preferences table that is not part of v1 backend schema.
-- Add in a future migration when the v2+ aggregate-data surface is built.
