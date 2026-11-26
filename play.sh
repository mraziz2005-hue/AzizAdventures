#!/usr/bin/env bash
set -e
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if command -v godot >/dev/null 2>&1; then
  exec godot --path "$DIR/game" "$@"
elif command -v godot4 >/dev/null 2>&1; then
  exec godot4 --path "$DIR/game" "$@"
else
  printf '%s\n' 'Godot 4.7.2 is required. Install the engine, then run this script again.' >&2
  exit 1
fi
