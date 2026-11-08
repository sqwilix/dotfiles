# CachyOS Workstation

A clean work-focused profile for CachyOS + KDE Plasma. Linux is intended for development and everyday work; Windows remains the gaming system.

## Principles

- Keep KDE Plasma; do not replace the desktop environment.
- Preserve the existing desktop appearance unless changes are explicitly requested.
- Install only core workstation and Rust development tools by default.
- Keep optional applications separate from the default installation.
- Never store credentials, private keys, browser profiles, caches or application databases here.

## Layout

- `apps/packages-pacman.txt` — core packages from CachyOS/Arch repositories.
- `apps/packages-optional.txt` — optional packages, not installed automatically.
- `scripts/install.sh` — interactive installer; asks before installing.
- `fish/config.fish` — minimal optional Fish configuration.
- `vscode/extensions.json` — recommended VS Code extensions.
- `templates/rust-toolchain.toml` — reusable Rust toolchain template.

## Install

Run from the repository root:

```bash
bash workstation/scripts/install.sh
```

Review the script before running it. It does not change your login shell, KDE settings, bootloader, partitions or Windows installation.

## Rust

The installer installs Rust through `rustup`, selects stable and adds rustfmt, Clippy and rust-analyzer.

## Safety

This profile is separate from the old dotfiles so the existing configuration is not overwritten. Adding `.gitignore` does not automatically untrack files already committed in Git; review old tracked files before publishing further changes.
