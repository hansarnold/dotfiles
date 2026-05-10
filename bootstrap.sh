#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_SUFFIX="$(date +%Y%m%d%H%M%S)"

configs=(
  ghostty
  kitty
  nvim
  tmux
  wezterm
  yazi
  zed
)

link_config() {
  local name="$1"
  local source="$DOTFILES_DIR/$name"
  local target="$CONFIG_HOME/$name"

  if [[ ! -e "$source" ]]; then
    printf 'skip: %s does not exist in dotfiles\n' "$name"
    return
  fi

  if [[ -d "$source" ]] && ! find "$source" -type f ! -name .gitkeep -print -quit | grep -q .; then
    printf 'skip: %s only contains placeholders\n' "$name"
    return
  fi

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      printf 'ok:   %s already linked\n' "$name"
      return
    fi
    printf 'move: %s existing symlink -> %s.bak-%s\n' "$target" "$target" "$BACKUP_SUFFIX"
    mv "$target" "$target.bak-$BACKUP_SUFFIX"
  elif [[ -e "$target" ]]; then
    printf 'move: %s -> %s.bak-%s\n' "$target" "$target" "$BACKUP_SUFFIX"
    mv "$target" "$target.bak-$BACKUP_SUFFIX"
  fi

  printf 'link: %s -> %s\n' "$target" "$source"
  ln -s "$source" "$target"
}

mkdir -p "$CONFIG_HOME"

for config in "${configs[@]}"; do
  link_config "$config"
done
