#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

PACKAGE_FILE="${PROFILE_DIR}/apps/packages-pacman.txt"
OPTIONAL_FILE="${PROFILE_DIR}/apps/packages-optional.txt"

if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman is required."
  echo "This installer supports CachyOS / Arch Linux."
  exit 1
fi

if [[ ! -f "${PACKAGE_FILE}" ]]; then
  echo "Error: package list not found: ${PACKAGE_FILE}"
  exit 1
fi

read_packages() {
  grep -Ev '^[[:space:]]*(#|$)' "$1" || true
}

mapfile -t packages < <(read_packages "${PACKAGE_FILE}")

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "Error: no packages found."
  exit 1
fi

echo "The following packages will be installed:"
printf '  %s\n' "${packages[@]}"

echo
read -r -p "Install core packages? [y/N] " answer

case "${answer}" in
  [yY]|[yY][eE][sS]) ;;
  *) echo "Cancelled."; exit 0 ;;
esac

sudo pacman -S --needed "${packages[@]}"

echo
read -r -p "Install optional applications? [y/N] " optional_answer

case "${optional_answer}" in
  [yY]|[yY][eE][sS])
    if [[ -f "${OPTIONAL_FILE}" ]]; then
      mapfile -t optional_packages < <(read_packages "${OPTIONAL_FILE}")

      if [[ ${#optional_packages[@]} -gt 0 ]]; then
        echo "Installing optional applications:"
        printf '  %s\n' "${optional_packages[@]}"
        sudo pacman -S --needed "${optional_packages[@]}"
      fi
    else
      echo "Optional package list not found. Skipping."
    fi
    ;;
  *) echo "Skipping optional applications." ;;
esac

echo

if command -v rustup >/dev/null 2>&1; then
  if ! rustup show active-toolchain >/dev/null 2>&1; then
    echo "No active Rust toolchain found."
    echo "Installing stable toolchain..."
    rustup toolchain install stable
    rustup default stable
  else
    echo "Existing Rust toolchain detected. Keeping current default."
  fi

  echo "Installing Rust components..."
  rustup component add rustfmt clippy rust-analyzer
else
  echo "Warning: rustup is not installed."
  echo "Rust setup skipped."
fi

echo
echo "Workstation setup completed."
echo "Check Rust with: rustc --version && cargo --version"
