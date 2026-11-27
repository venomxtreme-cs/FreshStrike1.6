#!/usr/bin/env bash
set -euo pipefail

./gradlew assembleGitRelease
cp app/build/outputs/apk/git/release/app-git-release.apk FreshStrike1.6.apk

echo "Built FreshStrike1.6.apk"
