# Headlines (Android)

Kotlin / Jetpack Compose port of the iOS `Headlines` app. Same Guardian-API headline
feed with a swipeable article pager, favouriting, and a favourites list — rebuilt with
Android idioms rather than translated line-by-line.

## How to run
1. Copy `local.properties.example` -> `local.properties` and set your Guardian API key
   (get one at https://bonobo.capi.gutools.co.uk/register/developer) and your `sdk.dir`:
   ```
   GUARDIAN_API_KEY=YOUR-KEY-HERE
   ```
2. Open the `android/` folder in Android Studio (or run `./gradlew assembleDebug` from
   here) and run on an emulator/device (minSdk 26).
3. `local.properties` is git-ignored; the key is exposed to the app via
   `BuildConfig.GUARDIAN_API_KEY`, generated from `app/build.gradle.kts`.

## Architecture
Same three layers as the iOS app, translated to their Android/Compose equivalents:
- **Presentation** — Compose screens (`ArticlePagerScreen`, `FavouritesScreen`) +
  `ViewModel`s exposing `StateFlow` UI state. Navigation via Navigation-Compose.
- **Domain** — `Article` model, repository interfaces, use cases (thin suspend
  wrappers, mirroring the iOS use case structs).
- **Data** — Retrofit (`GuardianApi`) for the network call, Room (`ArticleDao`) in
  place of Realm, mappers between DTO ⇄ domain ⇄ entity.

Dependency injection is a small hand-rolled `AppContainer` (see `di/`) rather than a
framework, mirroring the default-argument constructor injection used throughout the
iOS codebase.

## Key porting decisions
- **Realm → Room.** `ArticleDao.upsertContent` only ever updates headline/body/
  published/image columns on a refresh, never `isFavourited` — same partial-upsert
  trick the iOS `LocalArticlesService` used via Realm's `update: .modified` with a
  dictionary that omits `isFavourited`, so a remote refresh never clobbers a saved
  favourite. `ArticleDao.setFavourite` creates a sparse id-only row if none exists yet,
  matching the iOS service's behaviour.
- **Completion handlers → `suspend` + `Result`.** Every repository/use case method is
  `suspend fun … : Result<T>` instead of `(T?, Error?) -> Void`, which is the idiomatic
  Kotlin shape for "may fail, otherwise returns a value."
- **`CustomErrors` → `HeadlinesException`.** A sealed class of singleton exceptions
  with the same user-facing copy, instead of a `String`-backed `Error` enum.
- **UIPageViewController → `HorizontalPager`.** The swipeable full-screen article feed
  is one Compose screen backed by `foundation.pager.HorizontalPager`, rather than a
  `UIPageViewControllerDataSource` managing an array of child view controllers.
- **Mutable `Article` class → immutable `data class`.** Favouriting replaces an entry
  in the `ViewModel`'s state list (`state.copy(articles = …)`) rather than mutating a
  shared reference — the idiomatic Compose state-hoisting pattern.
- **SDWebImage → Coil.** `AsyncImage` replaces `sd_setImage(with:)`.
- **Search.** The iOS `UISearchController` was wired up but never implemented
  (`// TODO: Perform search`); the Compose `FavouritesScreen` actually filters by
  headline, since it cost nothing extra to finish it properly.
- Not ported: Alamofire (Retrofit/OkHttp instead), SDWebImage (Coil instead).

## Tests
`app/src/test` mirrors the iOS `HeadlinesTests` suite 1:1 — same spy classes (counters
instead of mocks), same use-case/repository test cases, same assertions on error
messages. Run with `./gradlew testDebugUnitTest`.

## Verified in this environment
`./gradlew :app:assembleDebug` and `./gradlew :app:testDebugUnitTest` both pass (10/10
unit tests). Not verified: running on an emulator/device, since none was available
here — install the `GUARDIAN_API_KEY` and run from Android Studio to try it live.
