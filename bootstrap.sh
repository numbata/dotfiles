#!/bin/sh

set -e # -e: exit on error

export HOMEBREW_NO_INTERACTIVE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# Check if 1Password CLI is installed
if ! command -v op &>/dev/null; then
  echo "Installing 1Password CLI..."
  brew install --quiet 1password/tap/1password-cli
fi

# Authenticate to 1Password if not already signed in
if ! op whoami &>/dev/null; then
  echo "Signing in to 1Password CLI..."
  eval $(op account add --signin --address my.1password.com)
fi

declare -r DOTFILES_REPO_URL="https://github.com/numbata/dotfiles"

if [ ! "$(command -v chezmoi)" ]; then
    bin_dir="$HOME/.local/bin"
    chezmoi="$bin_dir/chezmoi"
    if [ "$(command -v curl)" ]; then
        sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
    elif [ "$(command -v wget)" ]; then
        sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
    else
        echo "To install chezmoi, you must have curl or wget installed." >&2
        exit 1
    fi
else
    chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply "${DOTFILES_REPO_URL}"
