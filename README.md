# Dotfiles

My personal development environment configs — terminal emulators, editor, multiplexer, and dev tools. Everything is managed from `~/.config`.

## What's Included

| Config | Description |
|--------|-------------|
| [**Neovim**](nvim/README.md) | Full IDE setup with LSP, fuzzy finding, formatting, debugging, and [Claude Code](https://github.com/coder/claudecode.nvim) integration |
| [**Tmux**](tmux/README.md) | Terminal multiplexer with vim-style navigation and automatic session persistence |
| **Ghostty** | Terminal emulator — FiraCode Nerd Font, zsh shell integration, Everforest Dark theme |
| **Alacritty** | Terminal emulator — FiraCode Nerd Font, xterm-256color |
| **Wezterm** | Terminal emulator with shell integration |
| **Zed** | Editor — vim mode, Ayu theme, autosave |
| **btop** | System monitor with truecolor support |
| **clangd** | C/C++ LSP config — C++20 standard, Wall/Wextra warnings |
| **git** | Global git ignore |
| **iterm2** | iTerm2 app support config |
| **mcphub** | MCP Hub server configuration for Neovim |

## Quick Start

Clone the repo:

```bash
git clone git@github.com:sheghun/dependencies-config.git ~/.config
```

Or clone only what you need (e.g. just neovim):

```bash
git clone --depth 1 --filter=blob:none --sparse git@github.com:sheghun/dependencies-config.git ~/.config
cd ~/.config
git sparse-checkout set nvim
```

## Font

All terminal configs use **FiraCode Nerd Font**. Install it with:

```bash
brew install --cask font-fira-code-nerd-font
```

See individual READMEs for full setup instructions:

- [Neovim setup](nvim/README.md)
- [Tmux setup](tmux/README.md)
