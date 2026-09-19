#!/usr/bin/env bash
# restore.sh - set up dotfiles on a fresh machine

set -e

REPO="https://github.com/dovenglenn-lgtm/dotfiles.git"
DOTFILES="$HOME/dotfiles"

# Clone if not already present
if [ ! -d "$DOTFILES" ]; then
    git clone "$REPO" "$DOTFILES"
fi

# Symlink each config
for dir in "$DOTFILES"/*/; do
    name=$(basename "$dir")
    [ "$name" = ".git" ] && continue
    target="$HOME/.config/$name"
    source="$DOTFILES/$name"

    # Back up existing config if it exists
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mv "$target" "$target.bak"
        echo "Backed up existing $target to $target.bak"
    fi

    ln -sfn "$source" "$target"
    echo "Linked $target -> $source"
done

echo "Done. Configs restored."
