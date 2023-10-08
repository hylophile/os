#!/usr/bin/env bash
set -euxo pipefail

main() {
    true
    # dotfiles
    # fonts
}

gum spin "sh -c test"

msg_success() {
    gum style --border rounded --padding "0 1" --margin "0 2" --border-foreground "#00ff00" --width 25 "$@"
}

# Set up bare dotfiles.
dotfiles() {
    if [ ! -d "$HOME/.dotfiles" ]; then
        git clone --bare https://github.com/hylophile/.files.git "$HOME/.dotfiles"

        config() {
            git "--git-dir=$HOME/.dotfiles/" "--work-tree=$HOME" "$@"
        }

        rm -rf "$HOME/.config"

        config checkout

        config config status.showUntrackedFiles no
    fi

    msg_success "✅ Dotfiles"
}

# Download the fonts I use
fonts() {
    temp_dir=$(mktemp -d)
    pushd "$temp_dir"

    # Nerd fonts
    location=$(wget -qO- https://github.com/ryanoasis/nerd-fonts/releases/latest | grep SymbolsOnly.tar.xz | cut -d\" -f 2)
    wget -q "$location"
    tar xf NerdFontsSymbolsOnly.tar.xz

    # Jost
    git clone --depth 1 https://github.com/indestructible-type/Jost.git
    cp Jost/fonts/ttf/*.ttf .

    # Agave
    wget -q https://github.com/blobject/agave/releases/download/v37/Agave-Bold.ttf
    wget -q https://github.com/blobject/agave/releases/download/v37/Agave-Regular.ttf

    cp ./*.ttf ~/.local/share/fonts

    popd

    msg_success "🡅 Fonts"
}

main
