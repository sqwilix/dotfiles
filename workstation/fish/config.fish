# Additive Fish settings for the CachyOS workstation profile.
# Keep CachyOS defaults when they are installed.

if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

if status is-interactive
    alias ll='ls -lah'
    alias ..='cd ..'

    # Rust / Cargo shortcuts
    alias c='cargo'
    alias cb='cargo build'
    alias cr='cargo run'
    alias ct='cargo test'
    alias cc='cargo check'
end
