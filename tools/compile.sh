#!/bin/bash
# Compile O'Deadly Skyrim with Caprica.
# Usage:
#   CAPRICA=/path/to/caprica \
#   IMPORTS=/path/to/skyui:/path/to/skse:/path/to/ostim:/path/to/po3:/path/to/skyrimnet \
#   ./tools/compile.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CAPRICA="${CAPRICA:-caprica}"
OUT="$ROOT/build/Scripts"
mkdir -p "$OUT"
flags=(-i "$ROOT/src" -i "$ROOT/tools/stubs")   # stubs: compile-only, never shipped
IFS=':' read -ra dirs <<< "${IMPORTS:-}"
for d in "${dirs[@]}"; do
  if [ -n "$d" ]; then
    flags+=(-i "$d")
  fi
done
cd "$ROOT/src"
"$CAPRICA" -g skyrim --ignorecwd "${flags[@]}" -f "$ROOT/tools/TESV_Papyrus_Flags.flg" -o "$OUT" *.psc
