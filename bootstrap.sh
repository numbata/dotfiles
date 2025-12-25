#!/bin/bash

set -euo pipefail

export HOMEBREW_NO_INTERACTIVE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Set up Homebrew path (Apple Silicon vs Intel)
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
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

readonly DOTFILES_REPO_URL="https://github.com/numbata/dotfiles"

# Install chezmoi if not present
if ! command -v chezmoi &>/dev/null; then
    bin_dir="$HOME/.local/bin"
    chezmoi="$bin_dir/chezmoi"
    echo "Installing chezmoi..."
    if command -v curl &>/dev/null; then
        sh -c "$(curl -fsSL https://chezmoi.io/get)" -- -b "$bin_dir"
    elif command -v wget &>/dev/null; then
        sh -c "$(wget -qO- https://chezmoi.io/get)" -- -b "$bin_dir"
    else
        echo "Error: curl or wget required to install chezmoi" >&2
        exit 1
    fi
else
    chezmoi=chezmoi
fi

# Initialize and apply dotfiles
exec "$chezmoi" init --apply "${DOTFILES_REPO_URL}"
