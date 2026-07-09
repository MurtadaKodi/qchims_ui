#!/usr/bin/env bash
set -euo pipefail

# Build helper for Flutter macOS.
# Usage:
#   ./scripts/build_macos.sh          # normal build
#   ./scripts/build_macos.sh --clean  # clean + pod install + build

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CLEAN_FIRST=false
if [[ "${1:-}" == "--clean" ]]; then
  CLEAN_FIRST=true
fi

if [[ "$CLEAN_FIRST" == true ]]; then
  echo "[1/4] flutter clean"
  flutter clean
  echo "[2/4] flutter pub get"
  flutter pub get
  echo "[3/4] pod install (macos)"
  (cd macos && pod install)
  echo "[4/4] flutter build macos"
  flutter build macos
else
  echo "[1/2] pod install (macos)"
  (cd macos && pod install)
  echo "[2/2] flutter build macos"
  flutter build macos
fi

echo "Done: macOS build completed."
