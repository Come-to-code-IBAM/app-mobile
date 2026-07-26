# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter app (offline-first) for a digital herd register used by pastoralists:
biometric anti-theft identification, ration optimizer, and transhumance
conflict prevention. UI/French language throughout — code comments and doc
comments in this repo are written in French; keep new ones consistent with
that.

## Commands

```bash
flutter pub get                        # install dependencies
flutter analyze                        # static analysis (flutter_lints, see analysis_options.yaml)
flutter test                           # run all tests
flutter test test/widget_test.dart     # run a single test file
flutter run                            # run on a connected device/emulator
```

There is no backend in this repo. The server is a separate NestJS API; the
app talks to it only through `ApiClient` (`lib/core/network/api_client.dart`).
In dev on an Android emulator the host is `10.0.2.2` (see
`lib/core/config/constants.dart`).

## Architecture

**Current state**: the visual layer is fully built (27 screens, theming,
navigation wiring). The data/business layer is intentionally stubbed —
every method in `core/database`, `core/network`, `core/sync`, and
`data/repositories` throws `UnimplementedError()`. These are the extension
points; when implementing a feature, fill these in rather than adding new
parallel structures. Sale/ownership-transfer flows are explicitly not yet
designed.

**Dependency wiring**: `AppServices` (`lib/core/app/app_services.dart`) is
the single composition point — it assembles the DB, DAOs, repositories,
`ApiClient`, and `SyncService`. It's meant to be built once at startup and
exposed to the widget tree via `AppScope` (`lib/core/app/app_scope.dart`), a
plain `InheritedWidget` (deliberately not a heavier state-management
library — the app is small enough that this stays readable). Screens read
it with `AppScope.of(context)`. Note `main.dart`/`app.dart` do not currently
construct or provide an `AppServices`/`AppScope` — that wiring still needs
to be done as part of implementing the data layer.

**Offline-first data flow**: every write goes to local SQLite first
(`local_*` tables via DAOs in `core/database/daos/`), then a `SyncEvent` is
enqueued into the `outbox_event` table via `SyncDao` (idempotent, keyed by a
client-generated UUID). `SyncService` pushes the outbox to `/sync/push` and
pulls remote changes from `/sync/pull` opportunistically; the server is the
final authority for conflict resolution. Repositories
(`data/repositories/`) are the layer that owns this local-write +
outbox-enqueue sequencing — screens should call repositories, never DAOs or
`ApiClient` directly.

**Screens → repositories, never lower**: `features/` screens should depend
on `data/repositories/*`, which in turn depend on `core/database/daos/*`
and `core/sync`. `ApiClient` is the only network entry point and should
never be called directly from UI code — repositories decide when to sync.

**Feature module layout**: `lib/features/<module>/` groups screens by
domain area, not by screen type:
- `antivol/` — biometric anti-theft: enrollment, verification, theft
  reporting, herd list, animal detail (with `enroll/` and `verify/`
  sub-flows as capture → form/result step screens)
- `ration/` — ration optimizer flow (herd → feeds → result) + history
- `carte/` — map view, cultivated-zone declaration, track history, conflict
  alerts
- `parametres/` — settings (profile, sync, language, agent code, help)
- `shell/` — `HomeShell`, the 4-tab bottom-navigation container using an
  `IndexedStack` so tab state survives switching
- `splash/`, `onboarding/`, `auth/` — app entry flow

`app.dart` defines named routes (`routeSplash`, `routeLogin`, `routeHome`)
and applies `AppTheme.light` / `AppTheme.dark` (`themeMode: ThemeMode.system`).

**Theming**: `core/theme/` holds `AppColors`, `AppTypography`, `AppSpacing`
(+ `AppRadius`) and `AppTheme`, which builds the light/dark `ThemeData` from
these primitives. Prefer using the existing theme tokens (colors, spacing,
radii, `ColorScheme` roles) over hardcoding values in screens/widgets — the
shared look (navy filled buttons, generous card corners, filled inputs,
4-tab bottom nav) is centralized there.

**Shared widgets** (`lib/shared/widgets/`): reusable pieces used across
feature modules — `StatusBadge`, `ConnectivityIndicator`, `ModuleTile`,
`CameraFrame`, `LabeledField`, `DetailRow`, `AnimalListTile`,
`SectionHeader`, `BrandMark`. Check here before building a new one-off
widget that duplicates existing behavior.

**Models** (`lib/data/models/`) are plain local mirrors of server tables
(`Animal` ↔ `local_animal`, `SyncEvent` ↔ `outbox_event`, etc.) — no
serialization/business logic embedded, just data + related enums (e.g.
`AnimalStatus`, `AnimalSpecies`, `SyncOperation`).
