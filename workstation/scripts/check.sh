#!/usr/bin/env bash
set -u

check_command() {
    local command_name="$1"
    if command -v "$command_name" >/dev/null 2>&1; then
        printf '[ok] %-16s %s\n' "$command_name" "$(command -v "$command_name")"
    else
        printf '[missing] %s\n' "$command_name"
    fi
}

echo "=== Workstation ==="
check_command fish
check_command kitty
check_command code
check_command git

echo
echo "=== Rust ==="
check_command rustup
check_command rustc
check_command cargo

if command -v rustup >/dev/null 2>&1; then
    echo
    rustup show
    echo
    rustup component list --installed
fi

echo
echo "=== VS Code Rust extensions ==="
if command -v code >/dev/null 2>&1; then
    code --list-extensions 2>/dev/null | grep -Ei 'rust|crates|toml|lldb' || true
fi

echo
echo "=== KDE ==="
check_command plasmashell
if command -v plasmashell >/dev/null 2>&1; then
    plasmashell --version
fi
