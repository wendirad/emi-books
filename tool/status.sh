#!/usr/bin/env bash
# Reads and edits single lines of STATUS.md so agents never load the whole file.
#
#   status.sh open [area]            tasks not done, optionally for one area
#   status.sh show <ID>              a task and its subtasks (T012), or a feature (F-auth)
#   status.sh features               the feature table
#   status.sh add <area> <title> [parent-ID]   new task, or subtask under parent-ID
#   status.sh set <ID> <todo|doing|done|blocked>   change one task's mark
#   status.sh feature <ID> <state>   change one feature's state
#   status.sh archive                move finished top-level tasks to docs/status/archive.md
set -euo pipefail
cd "$(dirname "$0")/.."
file=STATUS.md
task='^ *- \[[ ~x!]\] T[0-9]+'

mark_for() {
  case "$1" in
    todo) echo ' ' ;; doing) echo '~' ;; done) echo 'x' ;; blocked) echo '!' ;;
    *) echo "unknown state '$1' (todo, doing, done, blocked)" >&2; exit 1 ;;
  esac
}

# Rewrites STATUS.md from awk's output, keeping the file untouched on failure.
rewrite() { local tmp; tmp=$(mktemp); "$@" >"$tmp" && cat "$tmp" >"$file"; rm -f "$tmp"; }

cmd=${1:-}
shift || true

case "$cmd" in
  open)
    area=${1:-}
    grep -nE "^ *- \[[ ~!]\] T[0-9]+" "$file" | { if [ -n "$area" ]; then grep -E " ${area}: |\.[0-9]+ "; else cat; fi; }
    ;;
  show)
    id=${1:?usage: status.sh show <ID>}
    grep -nE "^ *- \[.\] ${id}([. ])|^\| ${id} \|" "$file"
    ;;
  features)
    grep -nE '^\| F-' "$file"
    ;;
  add)
    area=${1:?usage: status.sh add <area> <title> [parent-ID]}
    title=${2:?usage: status.sh add <area> <title> [parent-ID]}
    parent=${3:-}
    if [ -z "$parent" ]; then
      last=$(grep -oE "^- \[.\] T[0-9]+" "$file" | grep -oE '[0-9]+$' | sort -n | tail -1 || true)
      id=$(printf 'T%03d' $((10#${last:-0} + 1)))
      line="- [ ] ${id} ${area}: ${title}"
      rewrite awk -v line="$line" '{print} END{print line}' "$file"
    else
      count=$(grep -cE "^ +- \[.\] ${parent}\.[0-9]+ " "$file" || true)
      id="${parent}.$((count + 1))"
      line="  - [ ] ${id} ${title}"
      at=$(grep -nE "^ +- \[.\] ${parent}\.[0-9]+ |^- \[.\] ${parent} " "$file" | tail -1 | cut -d: -f1)
      [ -n "$at" ] || { echo "no task $parent" >&2; exit 1; }
      rewrite awk -v at="$at" -v line="$line" '{print} NR==at{print line}' "$file"
    fi
    echo "$line"
    ;;
  set)
    id=${1:?usage: status.sh set <ID> <state>}
    m=$(mark_for "${2:?usage: status.sh set <ID> <state>}")
    grep -qE "^ *- \[.\] ${id} " "$file" || { echo "no task $id" >&2; exit 1; }
    rewrite awk -v id="$id" -v m="$m" '$0 ~ "^ *- \\[[ ~x!]\\] " id " " {sub(/\[[ ~x!]\]/, "[" m "]")} {print}' "$file"
    grep -E "^ *- \[.\] ${id} " "$file"
    ;;
  feature)
    id=${1:?usage: status.sh feature <ID> <state>}
    state=${2:?usage: status.sh feature <ID> <state>}
    grep -qE "^\| ${id} \|" "$file" || { echo "no feature $id" >&2; exit 1; }
    rewrite awk -F'|' -v OFS='|' -v id="$id" -v s="$state" \
      '$2 == " " id " " {$4 = " " s " "} {print}' "$file"
    grep -E "^\| ${id} \|" "$file"
    ;;
  archive)
    tmp=$(mktemp)
    # A finished top-level task leaves with its subtasks.
    awk -v arch="$tmp" '
      /^- \[x\] T[0-9]+ / {moving=1; print > arch; next}
      /^  - \[.\] T[0-9]+\./ && moving {print > arch; next}
      {moving=0; print}' "$file" >"$file.new"
    cat "$file.new" >"$file"; rm -f "$file.new"
    mkdir -p docs/status
    cat "$tmp" >>docs/status/archive.md
    echo "archived $(wc -l <"$tmp" | tr -d ' ') line(s)"
    rm -f "$tmp"
    ;;
  *)
    sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
    exit 1
    ;;
esac
