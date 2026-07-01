#!/usr/bin/env bash
# Symlink dotfiles into $HOME. Safe to re-run (idempotent).
# Existing real files are backed up to <file>.bak once.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Map: repo file -> target path in $HOME
link() {
  local src="$DOTFILES_DIR/$1"
  local dest="$2"

  if [ -L "$dest" ]; then
    rm "$dest"                       # replace existing symlink
  elif [ -e "$dest" ]; then
    echo "Backing up existing $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -s "$src" "$dest"
  echo "Linked $dest -> $src"
}

link vimrc "$HOME/.vimrc"

# Vim: extra after/syntax files
mkdir -p "$HOME/.vim/after/syntax"
link vim/after/syntax/c.vim "$HOME/.vim/after/syntax/c.vim"

# Ensure Vim's persistent-undo directory exists
mkdir -p "$HOME/.vim/undodir"

echo "Done."
