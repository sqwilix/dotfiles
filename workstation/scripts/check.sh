#!/usr/bin/env bash
set -u

check() {
  local label="$1"
  shift

  printf '\n== %s ==\n' "$label"

  if command -v "$1" >/dev/null 2>&1; then
    "$@"
  else
    printf 'Not found: %s\n' "$1"
  fi
}

check "System" uname -a
check "Shell" fish --version
check "Kitty" kitty --version
check "Rust compiler" rustc --version
check "Cargo" cargo --version
check "Rustup" rustup show
check "Git" git --version
check "KDE Plasma" plasmashell --version

printf '\n== Rust components ==\n'
if command -v rustup >/dev/null 2>&1; then
  rustup component list --installed
else
  printf 'Not found: rustup\n'
fi

printf '\n== VS Code ==\n'

EDITOR_CMD=""

if command -v code >/dev/null 2>&1; then
  EDITOR_CMD="code"
elif command -v codium >/dev/null 2>&1; then
  EDITOR_CMD="codium"
fi

if [[ -n "$EDITOR_CMD" ]]; then
  "$EDITOR_CMD" --version

  printf '\n== VS Code Rust extensions ==\n'
  "$EDITOR_CMD" --list-extensions | grep -Ei 'rust|toml|lldb' || \
    printf 'No matching extensions found.\n'
else
  printf 'Neither code nor codium was found.\n'
fi
