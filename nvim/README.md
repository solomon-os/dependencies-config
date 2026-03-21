# Neovim Config

My personal Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim) + [Mason](https://github.com/williamboman/mason.nvim).

## Prerequisites

### Neovim

Requires **Neovim 0.9+**.

```bash
brew install neovim
```

### Nerd Font

A [Nerd Font](https://www.nerdfonts.com/) is required for icons in the file tree, completions, and DB UI.

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

Set it as your terminal font (Ghostty, iTerm2, etc.).

### Language Runtimes

Install the runtimes for the languages you work with:

| Runtime | Install | Used by |
|---------|---------|---------|
| **Node.js 18+** | `brew install node` | ts_ls, prettier, eslint, mcp-hub |
| **Go 1.20+** | `brew install go` | gopls, gofumpt, golines, golangci-lint |
| **Rust** | [rustup.rs](https://rustup.rs/) | rust-analyzer, clippy, codelldb |
| **Python 3.8+** | `brew install python` | basedpyright, black |
| **C/C++ (clang)** | `brew install llvm` | clangd, clang-format |

### System Tools

```bash
# Fuzzy finder (required by fzf-lua)
brew install fzf

# C++ static analysis (optional, used by <leader>cc)
brew install cppcheck
```

### Global NPM Packages

```bash
npm install -g mcp-hub@latest
```

### JavaScript Debugging (optional)

Download [vscode-js-debug](https://github.com/microsoft/vscode-js-debug/releases) and extract to:

```
~/.config/vscode-js-debug/
```

### Prisma (optional)

If working with Prisma:

```bash
npm install -g prisma
```

## Setup

To clone only the nvim folder:

```bash
git clone --depth 1 --filter=blob:none --sparse git@github.com:sheghun/dependencies-config.git ~/.config
cd ~/.config
git sparse-checkout set nvim
```

Or if you already have the full repo, just symlink:

```bash
ln -s /path/to/dependencies-config/nvim ~/.config/nvim
```

Then:

1. Open Neovim — lazy.nvim will auto-install all plugins on first launch
2. Run `:MasonInstallAll` to install LSPs, formatters, and linters

Mason handles these automatically:

| Tool | Purpose |
|------|---------|
| lua-language-server | Lua LSP |
| stylua | Lua formatter |
| html-lsp | HTML LSP |
| css-lsp | CSS LSP |
| prettier | JS/TS/JSON formatter |
| gopls | Go LSP |
| golangci-lint | Go linter |
| json-lsp | JSON LSP |
| gomodifytags | Go struct tags |
| impl | Go interface impl |
| goimports_reviser | Go imports |
| golines | Go line length |
| gofumpt | Go formatter |
| eslint | JS/TS linter |
| basedpyright | Python LSP |
| black | Python formatter |
| sqlls | SQL LSP |
| solidity-ls | Solidity LSP |
| rust-analyzer | Rust LSP |
| codelldb | Rust/C++ debugger |

## Key Mappings

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file tree |
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>q` | Diagnostics (floating) |
| `gd` | Go to definition |
| `gr` | Show references (floating) |
| `K` | Hover info |
| `<leader>ca` | Code action |
| `<leader>ha` | Harpoon add |
| `<leader>hm` | Harpoon menu |

## Claude Code Integration

This config includes [claudecode.nvim](https://github.com/greggh/claudecode.nvim) for in-editor integration with [Claude Code](https://claude.com/claude-code). It enables Claude to read and edit files directly in your Neovim buffers when running Claude Code from the terminal.
