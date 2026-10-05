#!/usr/bin/env bash
# Finishes a task: generate, auto-fix, format changed files, analyze, test.
# Run it before declaring any change done. Stops at the first failure.
set -euo pipefail
cd "$(dirname "$0")/.."

flutter gen-l10n

if grep -rqs --include='*.dart' "\.g\.dart'" lib; then
  dart run build_runner build --delete-conflicting-outputs
fi

dart fix --apply

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  changed=$({ git diff --name-only HEAD -- '*.dart'; git ls-files -o --exclude-standard -- '*.dart'; } |
    grep -v -e '\.g\.dart$' -e '/generated/' | sort -u || true)
  if [ -n "$changed" ]; then
    echo "$changed" | tr '\n' '\0' | xargs -0 dart format
  fi
fi

flutter analyze
flutter test
  