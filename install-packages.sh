#!/bin/bash

dist=$(hostnamectl|grep "Operating System")

if [[ $dist =~ "Arch Linux" ]]; then
    echo "  # Arch Linux detected. Using pacman"
    echo "  # Installing cli & dev tools"
    sudo pacman -S --needed\
        base-devel\
        bat\
        fd\
        fzf\
        gcc\
        git\
        github-cli\
        kitty\
        luarocks\
        make cmake\
        man-db\
        postgresql\
        pyenv\
        rbenv ruby-build\
        ripgrep\
        ttf-hack-nerd\
        wget\
        wl-clipboard

    echo "  # Installing common apps"
    sudo pacman -S --needed\
        firefox\
        gparted btrfs-progs ntfs-3g\
        libreoffice-still\
        neovim\
        power-profiles-daemon\
        thunderbird\
        vlc

    echo "  # Installing oh-my-zsh plugins..."
    zshdir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    if [[ ! -d $zshdir/plugins/zsh-syntax-highlighting ]]; then
        echo "  # zsh-syntax-highlighting not found. Cloning..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zshdir/plugins/zsh-syntax-highlighting"
    else
        echo "  # zsh-syntax-highlighting already installed."
    fi
    if [[ ! -d $zshdir/plugins/zsh-autosuggestions ]]; then
        echo "  # zsh-autosuggestions not found. Cloning..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zshdir/plugins/zsh-autosuggestions"
    else
        echo "  # zsh-autosuggestions already installed."
    fi
fi
