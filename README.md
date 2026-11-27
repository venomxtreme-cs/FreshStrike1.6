# FreshStrike 1.6

<p align="center"><img src="logo.png" width="240" alt="FreshStrike logo"></p>

![Build](https://github.com/venomxtreme-cs/FreshStrike1.6/actions/workflows/build-apk.yml/badge.svg)

**FreshStrike 1.6** is an unofficial Counter-Strike 1.6 client for Android. It runs on a built-in Xash3D FWGS engine and ships with AMX Mod X, Metamod, YaPB and CS-EBOT, so you can play offline with bots or join online servers without installing a second app.

> This is the **build-only repository**. It contains the Android launcher, resources, assets and **prebuilt native libraries** needed to assemble the APK. The native engine/game sources are maintained separately.

---

## What is in the app

### Game and engine

- Counter-Strike 1.6 with a built-in Xash3D FWGS engine - no separate engine APK.
- Half-Life and Condition Zero support when their game files are present.
- GoldSrc rendering with mobile renderers (GL4ES, GLES1, GLES3 compatibility).
- Offline play with bots, listen server, and online multiplayer.

### Addons and modding

- **AMX Mod X 1.9** with **Metamod**.
- **YaPB** bots and **CS-EBOT** (Zombie Escape bot), switchable from the launcher.
- **ReGameDLL_CS** game logic.
- **On-device AMXX compiler** (`amxxpc`) - compile `.sma` plugins from the Compiler tab.
- **Plugins editor** for `plugins.ini` and `plugins-*.ini`.
- **Modules screen** with a live catalog for custom AMXX modules and Metamod plugins.
- Addons auto-install on first launch, with a one-tap reinstall option.

### Launcher and menus

- Remade CS 1.6-style launcher and GameUI.
- Main menu, tabbed Options, Create Server, server browser and player setup.
- Spray and player-logo pickers.
- Original-style background, logo, beveled dialogs and gold highlights.
- Storage permission banner, install status cards and engine log viewer.

### Touch controls

- Editable touch buttons and layouts, with presets and profiles.
- Touch menus for buy, team selection, commands and scoreboard.
- Gamepad and gyroscope support.
- Back-button handling that never closes the game by accident.
- Touch holds are released correctly when menus open or close (no stuck movement, look or `+showscores`).

### Display and performance

- **Real Android display modes** - switch the panel resolution, not just the HUD scale.
- Proportional console and HUD fonts that stay sharp at any resolution.
- **Advanced crosshair**: style, size, gap, thickness, outline, color, center dot and translucency, all applied live.
- Vsync, FPS cap and renderer selection.

### Stability and updates

- **Black-screen watchdog** that recreates the game surface automatically after a sustained failed swap.
- Deferred loading-window hide, so the first world frame is ready before the overlay disappears.
- Forced update checker with release notes, download progress and in-app APK install.
- Steam OpenID sign-in and Steam friends integration.

---

## Install

### Requirements

- Android 5.0 or newer (API 21+).
- ARM64 or ARMv7 device.
- About 150 MB of free space for the app and addons.

### Steps

1. Download **`FreshStrike1.6.apk`** from the [Releases](https://github.com/venomxtreme-cs/FreshStrike1.6/releases) page (or from the latest Actions artifact).
2. On Android, allow installs from your browser or file manager when prompted.
3. Install the APK. It uses the same signing key as CS16Fresh, so it updates over the old app.
4. Open FreshStrike and grant the storage/media permission when asked. The addons cannot install without it.
5. Wait for the first-launch addon unpack to finish.
6. Pick **Counter-Strike 1.6** and press **PLAY COUNTER-STRIKE**.

### Half-Life and Condition Zero

Counter-Strike 1.6 assets are bundled. For Half-Life or Condition Zero, copy your own game files first:

- Half-Life: `/sdcard/xash/valve`
- Condition Zero: `/sdcard/xash/czero`

Then choose the game from the launcher.

### Troubleshooting

| Problem | Fix |
|---|---|
| Addons do not install | Grant the storage/media permission, then use **Re-install addons**. |
| Touch buttons missing after a menu | Fixed in 1.36.18; update to the latest APK. |
| Black screen | The watchdog recovers automatically; if it persists, force-stop and relaunch. |
| Update not offered | Check that the latest release is published and tagged `1.36.NN`. |
| Half-Life/CZ missing files | Copy the `valve` or `czero` folder to `/sdcard/xash/`. |

---

## Build

### GitHub Actions (recommended)

The workflow is `.github/workflows/build-apk.yml`.

- Runs on every push to `main`/`master`, on pull requests, and manually from the **Actions** tab.
- Uploads the artifact **`FreshStrike1.6`** containing **`FreshStrike1.6.apk`**.
- Pushing a tag such as `1.36.19` or `v1.36.19` also publishes a GitHub Release with the APK attached.
- The update repository is filled automatically from `${{ github.repository }}`, so releases always point the updater at the right repo.

No secrets are required because the repository includes the signing keystore.

### Local build

Requirements:

- JDK 17 or newer (JDK 21 recommended).
- Android SDK with **platform 36** and **build-tools 36.0.0**.
- `ANDROID_HOME` pointing at the SDK.

Windows:

```bat
build.bat
```

Linux / macOS:

```bash
./build.sh
```

Or directly:

```bash
./gradlew assembleGitRelease
```

Output:

```
app/build/outputs/apk/git/release/app-git-release.apk
```

Copy it to `FreshStrike1.6.apk` if you want the release asset name used by the updater.

### Versioning

- `versionName` = `1.36.<build-number>-<git-hash>`
- `versionCode` = date-based, so it always increases.
- Bump `build-number.txt` for each release (for example `18` to `19`).

### Signing

`cs16client.keystore` is the key used by the existing app. Keeping it allows users to install new builds over old ones. For a production or Play Store build, replace it with a private keystore supplied through GitHub Actions secrets (`KEYSTORE_FILE_PATH`, `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`).

---

## Repository layout

| Path | Purpose |
|---|---|
| `.github/workflows/build-apk.yml` | CI build and release workflow |
| `app/src/main/java` | Launcher, settings, compiler, modules, Steam and update-checker sources |
| `app/src/main/res` | Layouts, drawables, strings and themes |
| `app/src/main/AndroidManifest.xml` | App manifest |
| `app/src/main/assets` | Addons, fonts, configs and touch layouts |
| `app/src/main/jniLibs` | Prebuilt native libraries for `arm64-v8a` and `armeabi-v7a` |
| `app/build.gradle` | APK assembly configuration |
| `gradle/`, `gradlew*` | Gradle wrapper |
| `cs16client.keystore` | Signing key |
| `build-number.txt` | Release number used in `versionName` |

The Gradle build does not compile native code. It packages the libraries already present in `app/src/main/jniLibs`.

---

## Author

**VX MOHA** - [@venomxtreme-cs](https://github.com/venomxtreme-cs)

---

## Legal

FreshStrike is an unofficial community project and is **not affiliated with or endorsed by Valve Corporation**. Counter-Strike, Half-Life and related marks are property of Valve. Game assets are included only to make the client usable with a legally owned copy of the game.

The app is built on open-source projects including Xash3D FWGS, CS16Client, ReGameDLL_CS, AMX Mod X, Metamod, YaPB, CS-EBOT, SDL2, gl4es and FFmpeg. See `NOTICE.md` for license details.
