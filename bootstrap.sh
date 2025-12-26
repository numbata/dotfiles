#!/bin/bash

set -euo pipefail

export HOMEBREW_NO_INTERACTIVE=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# Preheat sudo timestamp to avoid repeated prompts
if command -v sudo &>/dev/null; then
    sudo -v
fi

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
  if [[ -n "${OP_SERVICE_ACCOUNT_TOKEN:-}" || -n "${OP_CONNECT_HOST:-}" || -n "${OP_CONNECT_TOKEN:-}" ]]; then
    echo "Using existing 1Password service account or Connect credentials."
  else
    prompt_var() {
      local var_name="$1"
      local prompt="$2"
      local value="${!var_name:-}"
      if [[ -n "$value" ]]; then
        return 0
      fi
      if [[ -r /dev/tty ]]; then
        printf "%s" "$prompt" >/dev/tty
        read -r value </dev/tty
        printf -v "$var_name" "%s" "$value"
        export "$var_name"
      else
        echo "Error: $var_name is required. Set $var_name in the environment for non-interactive runs." >&2
        exit 1
      fi
      if [[ -z "${!var_name}" ]]; then
        echo "Error: $var_name cannot be empty." >&2
        exit 1
      fi
    }
    prompt_var OP_ADDRESS "Enter your 1Password sign-in address (example.1password.com): "
    prompt_var OP_EMAIL "Enter the email for your 1Password account: "
    op account add --signin --address "$OP_ADDRESS" --email "$OP_EMAIL"
  fi
  if ! op whoami &>/dev/null; then
    echo "Error: 1Password CLI is not signed in. Enable app integration or set OP_SERVICE_ACCOUNT_TOKEN." >&2
    exit 1
  fi
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
