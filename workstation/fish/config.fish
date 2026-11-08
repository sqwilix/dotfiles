# Minimal interactive Fish defaults.

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
