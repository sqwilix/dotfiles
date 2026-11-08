#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
PACKAGE_FILE="${PROFILE_DIR}/apps/packages-pacman.txt"

if ! command -v pacman >/dev/null 2>&1; then
  echo "This installer is intended for CachyOS / Arch Linux (pacman required)."
  exit 1
fi

if [[ ! -f "${PACKAGE_FILE}" ]]; then
  echo "Package list not found: ${PACKAGE_FILE}"
  exit 1
fi

mapfile -t packages < <(grep -Ev '^[[:space:]]*(#|$)' "${PACKAGE_FILE}")

echo "The following packages will be installed:"
printf '  %s\n' "${packages[@]}"
echo
read -r -p "Continue? [y/N] " answer

case "${answer}" in
  [yY]|[yY][eE][sS]) ;;
  *) echo "Cancelled."; exit 0 ;;
esac

sudo pacman -S --needed "${packages[@]}"

if command -v rustup >/dev/null 2>&1; then
  rustup default stable
  rustup component add rustfmt clippy rust-analyzer
fi

echo
echo "Workstation packages installed."
echo "Check Rust with: rustc --version && cargo --version"
