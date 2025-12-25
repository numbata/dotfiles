# Dotfiles by numbata

These are my personal dotfiles for setting up a new system quickly and consistently.
They include configurations for macOS, terminal tools, SSH/GPG keys, and various development tools.

## Quick Start

Run this command to bootstrap everything:

```bash
curl -sS https://raw.githubusercontent.com/numbata/dotfiles/main/bootstrap.sh | sh
```

This will:
- Install required tools (like Homebrew and 1Password CLI)
- Configure macOS defaults
- Set up terminal tools (e.g., tmux, Neovim, WezTerm)
- Manage SSH and GPG keys securely

## Key Features

- **Mac Setup:** Automatically applies macOS preferences.
- **SSH/GPG Keys:** Securely managed via 1Password.
- **Development Tools:** Includes configurations for Git, Neovim (with LSP), tmux, and more.
- **Customizations:** Easily remaps keys and sets up tools like Telescope, nvim-tree, and lualine.

## Cheat Sheet

### Shell

| Command | Description |
|---------|-------------|
| `z foo` | Jump to directory matching "foo" (learns from history) |
| `zi` | Interactive directory picker |
| `Ctrl+R` | Search shell history (atuin) |

### Modern CLI Aliases

| Alias | Tool | Description |
|-------|------|-------------|
| `ls`, `ll`, `la` | eza | Listing with colors, icons, git status |
| `lt` | eza | Tree view (2 levels) |
| `cat`, `less` | bat | Syntax highlighting |
| `find` | fd | Fast find, respects .gitignore |
| `top` | htop | Interactive process viewer |
| `lg` | lazygit | Terminal UI for git |
| `help` | tldr | Simplified man pages |

Original commands available with `o` prefix: `ocat`, `ols`, `ofind`, `otop`

### Version Management (mise)

| Command | Description |
|---------|-------------|
| `mise use node@20` | Install and use Node.js 20 |
| `mise use python@3.12` | Install and use Python 3.12 |
| `mise list` | Show installed versions |
| `mise current` | Show active versions |

### WezTerm (Leader: `Ctrl+a`)

| Shortcut | Description |
|----------|-------------|
| `Leader -` | Split pane vertically |
| `Leader \|` | Split pane horizontally |
| `Leader h/j/k/l` | Navigate panes |
| `Leader z` | Zoom/unzoom pane |
| `Cmd+t` | New tab |
| `Cmd+w` | Close tab |

### Neovim (Leader: `,`)

| Shortcut | Description |
|----------|-------------|
| `Ctrl+p` | Find files (Telescope) |
| `,fg` | Live grep (search in files) |
| `,d` | Toggle file explorer |
| `s` | Flash jump (type 2 chars) |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `,ca` | Code actions |
| `,f` | Format code |
| `Ctrl+h/j/k/l` | Navigate windows |

### Git Aliases

| Alias | Command |
|-------|---------|
| `git co` | checkout |
| `git ci` | commit -v |
| `git st` | status |
| `git up` | pull --rebase |
| `git put` | push origin HEAD |
| `git ls` | pretty log |
| `git graph` | visual commit graph |
| `git recent` | recently checked out branches |

## Notes

- Tested on macOS. Use at your own risk on other systems.

Enjoy your new system!
