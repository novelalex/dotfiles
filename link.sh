#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"


# from: https://github.com/rexim/dotfiles/blob/master/deploy.sh
symlinkFile() {
    filename="$SCRIPT_DIR/$1"
    destination="$HOME/$1"

    mkdir -p $(dirname "$destination")

    if [ -L "$destination" ]; then
        echo "[WARNING] $filename already symlinked"
        return
    fi

    if [ -e "$destination" ]; then
        echo "[ERROR] $destination exists but it's not a symlink. Please fix that manually"
        exit 1
    fi

    ln -s "$filename" "$destination"
    echo "[OK] $filename -> $destination"
}

symlinkFile .emacs.d/init.el
symlinkFile .emacs.themes
symlinkFile .emacs.local
