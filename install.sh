#!/bin/zsh

# FUNCTIONS ###################################################################

# rename target to target.backup
backup() {
    local target=$1
    local source=$2
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mv "$target" "$target.backup"
        echo "-----> Moved your old $target config file to $target.backup"
    elif [ -L "$target" ] && [ "$(readlink "$target")" != "$(realpath "$source")" ]; then
        read -rp "-----> $target is already a symlink to $(readlink "$target"). Replace it? [y/n] " replace
        if [ "$replace" = "y" ]; then
            rm "$target"
            echo "Removed the old symlink"
        else
            echo "Skipped $target"
        fi
    fi
}

symlink() {
    local file=$1
    local link=$2
    if [ ! -e "$link" ]; then
        echo "-----> Symlinking your new $link"
        ln -s "$file" "$link"
    fi
}

# MAIN ########################################################################

# Symlink files in dotfiles/
for name in $(basename -a dotfiles/*); do
    [ "$name" = "config" ] && continue # ignore .config dir

    link_path="$HOME/.$name"
    file_path="$PWD/dotfiles/$name"
    backup "$link_path" "$file_path"
    symlink "$file_path" "$link_path"
done

# Symlink folders in dotfiles/config/
for name in $(basename -a dotfiles/config/*); do
    link_path="$HOME/.config/$name"
    file_path="$PWD/dotfiles/config/$name"
    backup "$link_path" "$file_path"
    symlink "$file_path" "$link_path"
done

# Symlink only files in specific_files/**/*, not their entire directory
for name in $(find specific_files -type f -printf '%P\n'); do
    link_path="$HOME/.$name"
    file_path="$PWD/specific_files/$name"
    backup "$link_path" "$file_path"
    symlink "$file_path" "$link_path"
done
