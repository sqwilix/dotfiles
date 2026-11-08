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
check "VS Code" code --version
check "KDE Plasma" plasmashell --version

printf '\n== Rust components ==\n'
if command -v rustup >/dev/null 2>&1; then
  rustup component list --installed
fi

printf '\n== VS Code Rust extensions ==\n'
if command -v code >/dev/null 2>&1; then
  code --list-extensions | grep -Ei 'rust|toml|lldb' || true
fi
