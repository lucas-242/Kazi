# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Kazi is a Melos-managed Flutter monorepo for an earnings/service tracking ecosystem aimed at freelancers and service providers. Three packages under `packages/`:

- **kazi** — the main mobile app, published on Google Play. Firebase-backed (Firestore, Auth, Analytics, Crashlytics), with AdMob.
- **kazi_companies** — a business/enterprise-facing app (also targets web). Newer, no Firebase.
- **kazi_core** — a shared Flutter package: design-system widgets (`Kazi*`), entities, navigation, theming, localization, and API-backed repositories. Consumed by both apps via path dependency.

## Commands

Melos scripts fan out across all three packages (`melos run <script>`):

```bash
melos bootstrap              # link local packages — run this first, not `flutter pub get`
melos run analyze            # flutter analyze in every package
melos run test               # flutter test in every package
melos run build-runner       # dart run build_runner build -d (riverpod_generator, json_serializable, mockito)
melos run generate-l10n      # dart run intl_utils:generate — regenerates from ARB files
melos run flutter-clean
```

For a single package or test, work inside the package directory:

```bash
cd packages/kazi && flutter test test/lib/features/dashboard/presenter/controllers/dashboard_controller_test.dart
cd packages/kazi && flutter test --name "loads services ordered"
cd packages/kazi && dart run build_runner build -d
```

### Running the apps

`kazi` requires **both** a `--dart-define` and a matching Android `--flavor`; they are separate mechanisms and must agree:

```bash
cd packages/kazi
flutter run --dart-define APP_ENV=staging --flavor staging
```

`kazi_companies` has no Android flavors — `--dart-define` only:

```bash
cd packages/kazi_companies
flutter run --dart-define APP_ENV=staging
flutter run --dart-define APP_ENV=staging -d chrome --web-experimental-hot-reload
```

Prebuilt launch configs live in [.vscode/launch.json](.vscode/launch.json). Flavors: `staging`, `prod`, `prod_test`.

## Architecture

### Environment / flavor resolution

`Flavor` ([kazi_core/lib/shared/environment/flavor.dart](packages/kazi_core/lib/shared/environment/flavor.dart)) is shared, but each app resolves it independently. In `kazi`, [Environment](packages/kazi/lib/core/environment/environment.dart) reads the compile-time `APP_ENV` define, then loads a matching `.env.<flavor>` file via `flutter_dotenv` and returns a flavor-specific subclass. **The `.env.*` files are gitignored but are declared as Flutter assets** — a missing file breaks startup, so they must exist locally before running. `staging` uses `firebase_options_staging.dart`; `prod`/`prod_test` share `ProdEnvironment`, and `prod_test` exists to run production config with test ad units.

### Dependency injection in `kazi`

DI is **Riverpod-only** (get_it has been removed). App-level Firebase/ads dependencies are wired as `@Riverpod(keepAlive: true)` providers in [injector.dart](packages/kazi/lib/injector.dart) — `firebaseFirestoreProvider`, `crashlyticsServiceProvider`, `authServiceProvider`, `timeServiceProvider`, `serviceOrganizerProvider`, `servicesRepositoryProvider`, `catalogItemRepositoryProvider` — each returning a concrete `data/` implementation for its `domain/` interface. kazi_core's own dependencies (local storage, in-app review, API repositories) are wired separately in [kazi_providers.dart](packages/kazi_core/lib/kazi_providers.dart).

[main.dart](packages/kazi/lib/main.dart) does the async bootstrap imperatively (`Environment.load`, `FirebaseWrapper.initialize`, `MobileAds.initialize`), then creates a `ProviderContainer` (holding the `kaziAuthServiceProvider`/router/splash overrides), awaits `crashlyticsServiceProvider`'s `init()`, and hands that container to `runApp` via `UncontrolledProviderScope`. New app-level dependencies go in `injector.dart`; shared kazi_core dependencies go in kazi_core's providers. `kazi_companies` uses Riverpod only.

Consumers read dependencies with `ref.read`/`ref.watch(<name>Provider)` — controllers via their `ref`, widgets as `ConsumerWidget`/`ConsumerStatefulWidget`. Controller tests inject fakes with `ProviderContainer(overrides: [<name>Provider.overrideWithValue(mock)])`.

### `kazi` app structure

`kazi` is organized by feature under `lib/features/<feature>/` (`app_update`, `auth`, `clients`, `dashboard`, `onboarding`, `profile`, `services`, `subscription`), each layered:

- **`domain/`** — `models/` (entities/params), `repositories/` (interfaces), `services/` (service interfaces).
- **`data/`** — concrete implementations (`repositories/`, `services/`, feature-local `models/` for serialization, `errors/`).
- **`presenter/`** — `controllers/` (Riverpod controllers + their state classes), `pages/`, `widgets/`.

Each feature has a barrel (`<feature>.dart`) that also declares its `go_router` routes (`ServicesRoutes`, `AuthRoutes`, …). Cross-cutting code lives in `lib/core/` — `services/` (crashlytics, time, each split `domain/`+`data/`), `utils/` (`base_notifier.dart`, `base_state.dart`), `routes/`, `widgets/`, `constants/`, `environment/`, `extensions/`. App root files are `lib/app.dart` and `lib/app_shell.dart`.

### State management in `kazi`

Views use **Riverpod with codegen** for screen state (bloc/Cubit has been fully removed). Controllers live in `lib/features/<feature>/presenter/controllers/` as `@riverpod` / `@Riverpod(keepAlive: true)` classes (`DashboardController`, `ServiceLandingController`, …) whose `build()` returns the initial state; app-scoped controllers use `keepAlive: true`. They mix in [BaseNotifier / BaseAsyncNotifier](packages/kazi/lib/core/utils/base_notifier.dart), which standardize error handling: `onAppError` for known `AppError`s and `unexpectedError` for anything else, both setting `BaseStateStatus.error` with a localized message. Follow this pattern rather than hand-rolling error emission. State classes extend `BaseState`; pages are `ConsumerWidget`/`ConsumerStatefulWidget` and read via `ref.watch`/`ref.read`/`ref.listen`. Controller dependencies are read from the `injector.dart` providers via `ref.read(<name>Provider)`.

Controller tests use a Riverpod `ProviderContainer` + `mockito` (`*.mocks.dart` are generated): inject mocked repositories/services with `ProviderContainer(overrides: [<name>Provider.overrideWithValue(mock)])` in `setUp`, then read the controller via `container.read(provider.notifier)`. Firebase repository tests use `fake_cloud_firestore`.

`kazi_companies` also uses Riverpod for view state.

### Ads & subscriptions (freemium) in `kazi`

`kazi` monetizes via AdMob ads for free users and a RevenueCat monthly subscription. **Premium users see no ads and hit no limits** — the single premium check everywhere is `isPremiumProvider` (derived from `entitlementProvider`); don't reintroduce ad-hoc `subscriptionService.current()` checks in UI/controllers.

Both ad-display rules are centralized as objects under `lib/core/services/data/` (wired in `injector.dart`), so widgets/controllers never embed the policy:

- **Interstitial** (post-creation): `CreationAdCoordinator`. Creation controllers call `onCreationAction()` after a successful add; it shows the interstitial only every _N_ actions (persisted counter in local storage). A service form save counts as one action whatever its quantity. Service-form quick-adds pass `canShowNow: false` — they count but never surface an ad mid-form. The form calls `prepare()` on open so the ad is loaded by the save.
- **Banner** (service list and home today list): `BannerAdPolicy` — `shouldShowAfter(position, total:)`, positions counted across the whole list on screen, not per day group.

Frequency _N_ for both is read from Firebase Remote Config (`interstitial_ad_frequency`, `banner_ad_frequency`, keys in `RemoteConfigKeys`), falling back to a code default of 3. Ad unit ids come from `.env.<flavor>` (`SERVICE_CREATE_*`, `SERVICE_LIST_*`).

Freemium gating: creation controllers call `FreemiumGuard` (`checkAddServices`/`checkAddCatalogItem`/`checkAddClient`) **before** writing; it delegates to the pure `FreemiumGate`, returning a `GateResult`. On `isBlocked`, the controller calls `PaywallPromptController.promptFor(limit)` and a single listener in `app_shell.dart` presents the paywall. Tiers (`newFree`/`churned`/`premium`) and their limits live in `features/subscription/domain/` (`user_tier.dart`, `freemium_limits.dart`). RevenueCat dashboard/store identifiers are in `subscription_constants.dart`.

### Commission (and the legacy `discountPercent`)

A catalog item — and each service — stores `commissionPercent`: the share of the value the **user receives**. Null means no commission arrangement, which is 100%. It replaced `discountPercent`, which stored the mirror image (the share withheld).

Two rules, both about not re-splitting the vocabulary:

- **Never read `discountPercent` directly.** Read `effectiveCommissionPercent`, which resolves `commissionPercent` → `100 - discountPercent` for legacy documents → 100 (`Service`) / null (`CatalogItem`, meaning "not configured", which the service form turns into 100). Money getters follow from it: `Service.commissionValue` / `withheldValue`, aggregated as `ServiceTotals.commission` / `withheld` / `receivedCommission`.
- **Never write `discountPercent` as a source of truth.** Editing anything writes `commissionPercent`. `toMap` additionally writes `discountPercent` as a derived mirror (`legacyDiscountPercent`), because app versions already on Play read that key and nothing else — `FirebaseServiceModel` reads it into a non-nullable field, so omitting it would break them outright rather than just showing the wrong share. The mirror is write-only; it can be dropped once those versions are gone.

Untouched legacy documents are never rewritten — they keep their `discountPercent` and resolve correctly on read, so nothing needs a migration.

### Currency & exchange rates

Every service is registered in one of the `SupportedCurrency` values and displayed in the user's **default currency**. Two rules hold everywhere:

- **Never sum unconverted amounts.** `CurrencyConverter.convert` returns `double?` and yields `null` when a rate is missing — it must never fall back to the raw value, which would let 100 BRL enter a USD total as 100. Callers surface the null instead (see `ServiceTotals.unconverted` / `PartialTotalsNote`).
- **Never label an amount with a currency it is not stored in.** `NumberFormatUtils.formatCurrencyIn(value, currency)` is the only money formatter; there is deliberately no locale-derived variant.

**Where the rates live.** Daily snapshots (base USD, UTC `yyyy-MM-dd` keys) are one shared, global Firestore document per day: `exchangeRates/{date}` — not a copy per service. A service stores only `currency` + `rateDate`. There is no Cloud Function: the first client to open the app on a given day creates the document (`putIfAbsent`), and [firestore.rules](packages/kazi/firestore.rules) keeps that honest — create-only, id must equal today's UTC date, `fetchedAt` must be the server clock, no updates or deletes. Rules cannot iterate the rates map, so per-rate sanity (`> 0`, numeric) is enforced client-side in `ExchangeRates.fromMap`, which returns `null` for a tampered or corrupt document.

`ExchangeRateHistoryService` ([kazi_core](packages/kazi_core/lib/modules/currency/application/exchange_rate_history_service.dart)) resolves rates in layers — in-memory → local storage (`exchange_rates_cache`) → shared history → API (today only). It owns the in-memory cache, which is why its provider is the one thing here marked `keepAlive`. `RateBook.forDate` resolves exact day → closest **earlier** day → today's rates → null.

**Failure behaviour — nothing in this path throws, and no save ever fails because of rates:**

| Failure | Result |
|---|---|
| API fetch fails, cache has something | Converts with the newest cached snapshot (yesterday's rates). **Silent** — by design, since daily drift is fractional. |
| API fetch fails, cache empty | `RateBook` is empty → `convert` returns null → totals exclude those services and the UI says "rates unavailable". Services already in the default currency are unaffected (`from == to` short-circuits before any rate is needed). |
| `putIfAbsent` rejected or lost to a race | Swallowed; the device still uses the rates it fetched. Only cost: the day's document is not published, so other clients also hit the API until one write lands. |
| Firestore reads fail | Swallowed; falls through to the API for today, and older dates degrade to `latest` (today's rate instead of the historical one). |
| Rates unavailable while saving a service | The service still saves, anchored to `dateKeyOf(service.date)`; it converts correctly later, once the history covers that day. |
| Rates unavailable while switching currency in the form | The only user-facing failure: the switch is refused with a snackbar, rather than relabelling the typed amount. |

Known edge: the document id comes from the **device** clock while the rule compares against the **server** clock, so a badly skewed device crossing UTC midnight has its write rejected and anchors services to a key nobody else uses. It degrades to "previous day's rate", not to an error.

**Adding a currency.** Four edits, then codegen:

1. A value in `SupportedCurrency` ([supported_currency.dart](packages/kazi_core/lib/shared/currency/supported_currency.dart)) — plus a `fromCountryCode` entry so the device guess can preselect it. Give it a **disambiguated symbol** if the bare one collides (`CA$`, `AR$`, not `$`), and take `decimalDigits` from ISO 4217 (0 for UGX/PYG, 2 for the rest).
2. `currency<ISO>` in the three ARBs, then `melos run generate-l10n`.
3. The `switch` in `supported_currency_l10n.dart` — exhaustive, so the compiler points at it.
4. `ExchangeRateMock.rates`, so tests and kazi_companies see it.

Everything else follows automatically: the pickers, the form dropdown and the migration page all iterate `SupportedCurrency.values`, `ApiExchangeRateRepository` filters the API response by the same list, and the Firestore rules carry no currency list. Confirm the API actually quotes it first — `curl https://open.er-api.com/v6/latest/USD`.

The one thing that does **not** fix itself is history: daily documents are immutable, so every snapshot written before the change lacks the new currency, permanently. `RateBook.forPair` covers this by falling back to the newest snapshot that knows both currencies — trading the historical rate for a current one, rather than dropping older amounts out of the totals. Convert through `forPair`, never `forDate`; `forDate` is for anchoring a date, where the currencies are irrelevant.

**Default currency and the migration.** The default currency lives on `users/{uid}` in Firestore — the app's only per-user document — because local storage is cleared on sign-out, and a device-only copy made returning users read stored BRL amounts as USD. kazi_core owns the contract (`KaziRemoteCurrencyStore`, overridden in `main.dart`); local storage is just a first-frame cache. Reads go through `kaziDefaultCurrencyProvider`.

Users whose data predates all this are asked once, on a blocking route gated by `kaziCurrencyMigrationRequiredProvider` (same shape as the forced-update gate, but after auth and onboarding). `CurrencyMigrationController.confirm` writes the currency, backfills legacy documents, and only **then** sets `currencyMigratedAt` — so an interrupted run reappears next launch and skips what it already stamped. Users with no data complete silently. The backfill pages with `where(FieldPath.documentId, isGreaterThan: lastId)`, not `startAfterDocument`, because `fake_cloud_firestore` returns nothing for cursor paging over `__name__`.

### Design system (colours and type)

Full decision tables live in [themes/README.md](packages/kazi_core/lib/shared/themes/README.md); the short version is two rules, and both exist to keep a screen from ever asking what brightness it is in:

- **Colour comes from `context.colors`** (`KaziColors`, a `ThemeExtension`) — and only from there. It carries everything: surfaces (`background`/`card`/`surfaceMuted`/`surfaceStrong`), ink (`text`/`textMuted`), borders, the brand yellow (`brand.*`), the four identically-shaped status groups (`success`/`warning`/`info`/`danger`, each `fill`/`onFill`/`surface`/`onSurface`), `money.*`, `hero.*` and `category(i)`. There is **no** `context.colorsScheme`: the Material `ColorScheme` is plumbing held in `colors.scheme`, and only [kazi_theme_settings.dart](packages/kazi_core/lib/shared/themes/settings/kazi_theme_settings.dart) reads it. The raw palette (`KaziPalette`) is deliberately **not exported from the barrel**, so reaching for a hex in a screen is a compile error.
- **Type comes from `KaziTextStyles`**, whose fifteen slots are named exactly as Flutter's `TextTheme` names them (`bodyMedium`, `titleSmall`, …). Only `amount`/`amountAt`, `tag` and `wordmarkAt` sit outside the Material scale. The statics are colourless on purpose — `Text` inherits colour from the ambient `DefaultTextStyle` — so use `context.text.<slot>` when you want the pre-coloured copy.

Two traps the naming is designed to avoid: the brand yellow is **1.4:1 on Névoa**, so `brand.fill` (a surface) and `brand.text` (amber on light, yellow on dark) are separate tokens — never write in `scheme.primary`; and a status colour's `fill` is for dots and solid chips while `onSurface` is the readable text form. For a status bar over any background, `colors.overlayOn(background)` derives the icon brightness — do not hand-write the ternary.

`KaziThemeGalleryPage` renders every token in both brightnesses at once, wired in debug builds only at Menu → Debug → Design tokens (`/settings/design-tokens`). Add new tokens to it, or nobody will find them.

### Naming collision between `kazi` and `kazi_core`

`kazi` imports kazi_core with an exclusion list:

```dart
import 'package:kazi_core/kazi_core.dart' hide Service, CatalogItem, CatalogItemRepository;
```

The app defines its own Firestore-backed `Service`/`CatalogItem`/`CatalogItemRepository` that shadow kazi_core's API-backed versions. Preserve the `hide` clause when adding imports in `kazi`, or you get ambiguous-import errors.

### Routing

Both apps use `go_router`, but wire it differently. `kazi` exposes a `routerProvider` ([app_router.dart](packages/kazi/lib/core/routes/app_router.dart)) where `RouterNotifier` listens to `appStartupProvider` and `isAuthenticatedProvider` and drives redirects; authenticated routes sit inside a `ShellRoute` behind `AppShell`. Route definitions are grouped per feature — each feature barrel exposes them (`DashboardRoutes.shellRoute()`, `AuthRoutes.routes`, …) rather than declaring routes inline.

kazi_core provides an app-agnostic navigation layer ([shared/navigation/](packages/kazi_core/lib/shared/navigation/)): `KaziNavigator` is a static wrapper over a `GoRouter` that must be initialized (`KaziNavigator.init(router)`) before use and tracks current/previous `KaziPage`. Each app subclasses it (`AppNavigator`).

### kazi_core layering

`lib/modules/<name>/` is layered `domain/` (repository interfaces, param models) and `data/` (API implementations, mocks); `lib/shared/` holds cross-cutting UI and utilities. Everything public is re-exported from the [kazi_core.dart](packages/kazi_core/lib/kazi_core.dart) barrel — new public API must be added there or consumers can't see it.

The barrel also re-exports the shared third-party packages both apps depend on, including **Riverpod** (`flutter_riverpod` + `riverpod_annotation`), so consumers get `ProviderScope`, `ConsumerWidget`, `@riverpod`, `$Notifier`, … from the kazi_core import. The barrel opts out of the `invalid_export_of_internal_element` warning because riverpod's generated code relies on internal `$`-prefixed exports.

`flutter_riverpod` (the widget/runtime bindings) is declared **only in kazi_core** — `kazi` consumes it transitively through the barrel and does not list it in its own `pubspec.yaml`. However, each app that runs riverpod codegen **must keep `riverpod_annotation` as a direct dependency plus `riverpod_generator` + `build_runner` as dev dependencies** — `riverpod_generator`'s builder auto-applies based on a direct `riverpod_annotation` dependency, so removing it silently stops `.g.dart` generation (only surfaced after a `build_runner clean`).

### Localization

ARB files live in **kazi_core** ([lib/shared/l10n/arb/](packages/kazi_core/lib/shared/l10n/arb/)) — `en`, `es`, `pt`, with `en` as the main locale. Generated into `KaziLocalizations`, accessed statically as `KaziLocalizations.current.<key>`. Add strings to the kazi_core ARBs and run `melos run generate-l10n`; generated output is gitignored from analysis.

## Comments and documentation

Comments follow Uncle Bob's premise from *Clean Code*: **a comment is a failure to express something in code.** Code cannot lie about what it does; a comment can, and rots the moment someone edits the line under it. So the first move is never to write the comment — it is to rename the variable, extract the function, or introduce the named constant that makes the comment unnecessary.

Two questions decide everything:

1. **Does the code already say this?** If yes, delete the comment. A comment that restates the line under it (`// loads the types`, `/// The user's id.`) is noise with a maintenance cost.
2. **Is this a *why* that a reader could not derive from the code?** If yes, it stays — as short as it can be said. If it takes more than ~3 lines to say, it does not belong in the source file (see below).

### What may stay in the source

- **Warnings of consequence** — the non-obvious thing that breaks if someone "simplifies" this. (`read`, not `watch`, or completing the flow rebuilds the controller and drops the user's answers.)
- **Intent behind a non-obvious choice** — why *this* approach and not the one the reader would expect.
- **`TODO:` / `FIXME:`** with what is missing, not with an apology.
- **`///` dartdoc on public API of `kazi_core`** — it is a package consumed by two apps; its exported surface documents contracts, units, and null semantics. Say what the thing *is* and what its edges are, in a sentence or two.

### What does not belong in the source

- Redundant restatements, position markers (`// ------- navigation`), closing-brace notes, bylines, and commented-out code (git remembers it).
- Journal / changelog entries — "used to be X", "replaced Y", "kept for the migration". History lives in git and, when it constrains today's code, in a doc.
- Product or design rationale — why the subtotal sits in the section header, what the screen is *for*, what the target time-to-first-value is.
- Narrative or persuasive prose. A comment is a note to the next maintainer, not an essay.
- Dartdoc on private members whose name and body already say it.

### Unusual rules go to markdown

When a rule is genuinely out of the ordinary — a domain invariant, an external-system constraint, a workaround for a third-party bug, a decision with real consequences for anyone touching the area — it goes in a **markdown document colocated with the code it governs**, following the existing precedent ([themes/README.md](packages/kazi_core/lib/shared/themes/README.md), [analytics/README.md](packages/kazi/lib/core/services/data/analytics/README.md)). Write the full explanation there — tables, failure modes, examples — and leave in the code at most a one-line pointer:

```dart
// Rates may be missing; never falls back to the raw value. See README.md.
```

Prefer one README per module or feature over many scattered ones. Cross-cutting rules that span packages (commission, currency, freemium, design system) belong in this file or in the module README it points to — never duplicated in both.

## Conventions

- Lints are stricter than `flutter_lints` defaults ([analysis_options.yaml](analysis_options.yaml)): single quotes, trailing commas required, explicit return types, `prefer_final_locals`, constructors sorted first. Run `melos run analyze` before considering work done.
- Shared widgets are prefixed `Kazi` (`KaziElevatedButton`, `KaziDropdown`, …). Check the kazi_core barrel for an existing component before building a new one in an app.
- Versioning uses `melos version` with conventional commits; commit messages in this repo follow `feat:` / `refactor:` / `build:` prefixes.
- Melos scripts and some code comments are in Portuguese; user-facing strings always go through ARB files.
- Comments are held to the rules in [Comments and documentation](#comments-and-documentation): delete what the code already says, keep the non-obvious *why*, and move anything longer than a few lines into a colocated markdown doc.
