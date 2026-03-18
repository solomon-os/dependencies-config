# Tmux Config

My tmux config with vim-style navigation and session persistence.

## Prerequisites

```bash
brew install tmux
```

### TPM (Tmux Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After launching tmux, press `C-Space I` (prefix + I) to install plugins.

## Plugins

| Plugin | Purpose |
|--------|---------|
| [tpm](https://github.com/tmux-plugins/tpm) | Plugin manager |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save/restore sessions across restarts |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions every 2 minutes + auto-restore |

## Key Bindings

Prefix is `C-Space` (Ctrl+Space).

### Pane Navigation (vim-style)

| Key | Action |
|-----|--------|
| `prefix h` | Move to left pane |
| `prefix j` | Move to down pane |
| `prefix k` | Move to up pane |
| `prefix l` | Move to right pane |

### Pane Resizing

| Key | Action |
|-----|--------|
| `prefix H` | Resize left |
| `prefix J` | Resize down |
| `prefix K` | Resize up |
| `prefix L` | Resize right |

### Copy Mode (vim-style)

| Key | Action |
|-----|--------|
| `prefix v` | Enter copy mode |
| `v` (in copy mode) | Begin selection |
| `y` (in copy mode) | Yank to clipboard |

## Setup

1. Symlink or copy `.tmux.conf` to `~/.config/tmux/.tmux.conf`
2. Install TPM (see above)
3. Launch tmux and press `C-Space I` to install plugins
