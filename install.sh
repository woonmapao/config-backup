#!/usr/bin/env bash
# Bootstrap a new Mac from this dotfiles repo.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak.$(date +%s)"
  fi
  ln -sf "$src" "$dst"
}

link "$DIR/.zshrc" ~/.zshrc
link "$DIR/.zprofile" ~/.zprofile
link "$DIR/.gitconfig" ~/.gitconfig
link "$DIR/starship.toml" ~/.config/starship.toml
link "$DIR/docker_config.json" ~/.docker/config.json

CURSOR_USER="$HOME/Library/Application Support/Cursor/User"
link "$DIR/vsc_cfg/settings.json" "$CURSOR_USER/settings.json"
link "$DIR/vsc_cfg/keybindings.json" "$CURSOR_USER/keybindings.json"

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --file="$DIR/Brewfile"

echo "Done. Open a new terminal tab, then: gh auth login"
