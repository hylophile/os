#!/usr/bin/env bash
set -euo pipefail

msg() {
    gum style --border rounded --padding "0 1" --margin "0 2" --border-foreground "#00ff00" --width 25 "$@"
}

# Set up bare dotfiles.
if [ ! -d "$HOME/.dotfiles" ]; then
    git clone --bare https://github.com/hylophile/.files.git "$HOME/.dotfiles"

    config() {
    git "--git-dir=$HOME/.dotfiles/" "--work-tree=$HOME" "$@"
    }

    rm -rf "$HOME/.config"

    config checkout

    config config status.showUntrackedFiles no
fi

msg "✅ Dotfiles"
