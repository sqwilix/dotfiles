# CachyOS Workstation

A clean, work-focused workstation profile for CachyOS + KDE Plasma. Linux is intended for development and everyday work; Windows remains the gaming system.

## Principles

- Keep KDE Plasma; do not replace the desktop environment.
- Preserve the existing desktop appearance unless changes are explicitly requested.
- Install core workstation and Rust development tools with user confirmation.
- Keep optional applications separate from the default installation.
- Never store credentials, private keys, browser profiles, caches or application databases here.
- Prefer portable settings and avoid destructive system changes.

## Layout

- `apps/packages-pacman.txt` — core packages from CachyOS/Arch repositories.
- `apps/packages-optional.txt` — optional packages, installed only when selected.
- `scripts/install.sh` — interactive installer for packages and Rust components.
- `scripts/check.sh` — read-only workstation and Rust environment check.
- `fish/config.fish` — additional Fish aliases and interactive defaults.
- `kitty/` — modular Kitty configuration, including theme, fonts and keybindings.
- `vscode/settings.json` — recommended editor settings.
- `vscode/extensions.json` — recommended VS Code extensions.
- `templates/` — reusable Rust project configuration files.

## Requirements

- CachyOS or another Arch-based Linux distribution.
- `pacman` package manager.
- Internet connection.
- `sudo` privileges for package installation.

## Install

Clone the repository and enter its directory:

```bash
git clone https://github.com/sqwilix/dotfiles.git
cd dotfiles
```

Run the workstation installer:

```bash
bash workstation/scripts/install.sh
```

The installer asks for confirmation before installing core packages and optional applications. It also configures the Rust stable toolchain and required components through `rustup`.

Review the script before running it.

## Check the current setup

Run the diagnostic script:

```bash
bash workstation/scripts/check.sh
```

This script checks installed tools and Rust components. It does not install packages or modify system settings.

## Fish configuration

The Fish configuration contains a small set of additional aliases and defaults.

Review `fish/config.fish` and merge its contents into your existing Fish configuration if desired. Avoid blindly replacing an existing configuration.

## Kitty configuration

The Kitty configuration is split into a main file and smaller files under `kitty/conf.d/`.

Back up your existing `~/.config/kitty` directory before applying these files. Review the configuration before replacing anything.

The profile uses JetBrainsMono Nerd Font. The installer includes the corresponding font package.

## VS Code

The `vscode/` directory contains editor settings and recommended extensions.

- `settings.json` — editor, Rust Analyzer and terminal settings.
- `extensions.json` — suggested extensions for Rust development.

These files are templates. Review and merge the settings into your editor's user configuration. Install recommended extensions through the editor.

VS Code and Code - OSS may use different configuration directories.

## Rust

The profile uses `rustup` with the stable toolchain.

The installer:

- Installs stable if no active toolchain is detected.
- Keeps an existing active toolchain.
- Installs `rustfmt`, `clippy` and `rust-analyzer` components.

The `templates/rust-toolchain.toml` file can be copied into individual Rust projects when needed.

## Safety

This profile is separate from the original personal dotfiles to avoid overwriting existing configuration.

The installer does not change your login shell, KDE settings, bootloader, partitions or Windows installation. It does install selected system packages and Rust components after confirmation.

`.gitignore` does not automatically untrack files already committed in Git. Always review tracked files before publishing changes.
