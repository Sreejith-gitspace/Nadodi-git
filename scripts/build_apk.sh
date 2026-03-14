#!/usr/bin/env bash
set -euo pipefail

# Make sure Flutter is installed and available on PATH.
# Run this script from repository root.

if ! command -v flutter &> /dev/null; then
  echo "Flutter is not installed or not on PATH."
  exit 1
fi

# Ensure project structure is created (this will not override existing files unless --overwrite is used)
flutter create . || true

flutter pub get

# Build a release APK
flutter build apk --release

echo "APK built at build/app/outputs/flutter-apk/app-release.apk"
