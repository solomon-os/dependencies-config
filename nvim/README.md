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
brew install --cask font-fira-code-nerd-font
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

Leader key is `<Space>`.

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Esc>` | Normal | Clear search highlights |
| `;` | Normal | Enter command mode |
| `jk` | Insert | Exit insert mode |
| `jk` | Terminal | Exit terminal mode |

### Window Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` | Normal | Move to left window |
| `<C-j>` | Normal | Move to down window |
| `<C-k>` | Normal | Move to up window |
| `<C-l>` | Normal | Move to right window |

### Buffer Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | Normal | Next buffer |
| `<S-Tab>` | Normal | Previous buffer |
| `<leader>x` | Normal | Close buffer |

### File Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` | Normal | Toggle file tree |
| `<leader>e` | Normal | Focus file tree |
| `<leader>ff` | Normal | Find files |
| `<leader>fw` | Normal | Live grep |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Help tags |
| `<leader>fo` | Normal | Recent files |
| `<leader>fr` | Normal | Search in directory (prompts for path) |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Show references (floating picker) |
| `gi` | Normal | Go to implementation |
| `K` | Normal | Hover info |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |
| `<leader>lf` | Normal | Open floating diagnostic |
| `<leader>q` | Normal | Buffer diagnostics (floating picker) |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gc` | Normal | Git commits |
| `<leader>gb` | Normal | Git branches |
| `<leader>gs` | Normal | Git status |
| `<leader>gh` | Normal | Next git hunk |

### Harpoon

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ha` | Normal | Add file to harpoon |
| `<leader>hr` | Normal | Remove file from harpoon |
| `<leader>hm` | Normal | Toggle harpoon menu |
| `<leader>h1-4` | Normal | Jump to harpoon file 1-4 |

### Debugging (DAP)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dc` | Normal | Debug continue |
| `<leader>du` | Normal | Toggle DAP UI |
| `<leader>dh` | Normal | Hover/evaluate expression |
| `<leader>dt` | Normal | Debug test (Go) |
| `<leader>df` | Normal | Show stack frames |
| `<F6>` | Normal | Open REPL |
| `<F9>` | Normal | Run last debug config |
| `<F12>` | Normal | Step out |

### Trouble

| Key | Mode | Action |
|-----|------|--------|
| `<leader>xx` | Normal | Toggle diagnostics |
| `<leader>xX` | Normal | Toggle buffer diagnostics |
| `<leader>xs` | Normal | Toggle symbols |

### Terminal (Snacks)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>th` | Normal | Terminal (horizontal split) |
| `<leader>tv` | Normal | Terminal (vertical split) |

### Other

| Key | Mode | Action |
|-----|------|--------|
| `<leader>nh` | Normal | Notification history |
| `<leader>cc` | Normal | Run cppcheck on project |

## Claude Code Integration

This config includes [claudecode.nvim](https://github.com/coder/claudecode.nvim) for in-editor integration with [Claude Code](https://claude.com/claude-code). It enables Claude to read and edit files directly in your Neovim buffers.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ac` | Normal | Toggle Claude Code terminal |
| `<leader>af` | Normal | Focus Claude panel |
| `<leader>as` | Visual | Send selection to Claude |
| `<leader>am` | Normal | Select Claude model |
| `<leader>ab` | Normal | Add current buffer to Claude context |
| `<leader>aa` | Normal | Accept diff |
| `<leader>ad` | Normal | Deny diff |
| `<leader>ar` | Normal | Resume Claude conversation |
| `<leader>ao` | Normal | Continue last Claude conversation |

See the [claudecode.nvim repo](https://github.com/coder/claudecode.nvim) for more information.
