#!/usr/bin/env bash
# One-shot Neovim setup for Ubuntu/Debian: installs Neovim + tool dependencies,
# clones this config to ~/.config/nvim (backing up any existing one), and syncs plugins.
set -euo pipefail

REPO_URL="https://github.com/VarunSharma3520/nvim.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

if ! command -v apt >/dev/null 2>&1; then
  echo "This script supports apt-based systems (Ubuntu/Debian) only." >&2
  exit 1
fi

SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

log "Installing dependencies"
$SUDO apt update
$SUDO apt install -y \
  git curl wget unzip ca-certificates software-properties-common \
  build-essential ripgrep fd-find xclip \
  nodejs npm python3 python3-pip python3-venv golang-go

log "Installing Neovim (latest from PPA)"
if ! command -v nvim >/dev/null 2>&1 || [ "$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1 | tr -d .)" -lt 011 ]; then
  $SUDO add-apt-repository -y ppa:neovim-ppa/unstable
  $SUDO apt update
  $SUDO apt install -y neovim
fi
nvim --version | head -1

log "Installing config to $CONFIG_DIR"
if [ -d "$CONFIG_DIR/.git" ] && git -C "$CONFIG_DIR" remote get-url origin 2>/dev/null | grep -q "VarunSharma3520/nvim"; then
  git -C "$CONFIG_DIR" pull --ff-only
else
  if [ -e "$CONFIG_DIR" ]; then
    BACKUP="$CONFIG_DIR.bak.$(date +%Y%m%d%H%M%S)"
    echo "Existing config found, moving to $BACKUP"
    mv "$CONFIG_DIR" "$BACKUP"
  fi
  git clone "$REPO_URL" "$CONFIG_DIR"
fi

log "Installing plugins (lazy.nvim) and LSP tools (mason)"
nvim --headless "+Lazy! sync" +qa || true

log "Done. Run 'nvim' to start; Mason will finish installing language servers on first launch."
