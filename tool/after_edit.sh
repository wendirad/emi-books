#!/usr/bin/env bash
# Claude Code PostToolUse hook: fixes lints and formats the file just edited,
# and regenerates l10n when an .arb file changed and model code when a model with
# a .g.dart part changed. Never fails the edit.
file=$(sed -n 's/.*"file_path" *: *"\([^"]*\)".*/\1/p' | head -n 1)
cd "$(dirname "$0")/.." || exit 0

case "$file" in
  *.arb) flutter gen-l10n >/dev/null 2>&1 ;;
  *.g.dart | */generated/*) ;;
  *.dart)
    dart fix --apply "$file" >/dev/null 2>&1
    dart format "$file" >/dev/null 2>&1
    if grep -qs "\.g\.dart'" "$file"; then
      dart run build_runner build --delete-conflicting-outputs >/dev/null 2>&1
    fi
    ;;
esac
exit 0
