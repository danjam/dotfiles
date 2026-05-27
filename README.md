# Dotfiles

Zsh + Oh My Zsh + Oh My Posh, managed with symlinks and an idempotent install script. Works on WSL2, macOS, and Linux.

## Setup

```bash
git clone git@github.com:danjam/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
exec zsh
```

Re-run `install.sh` to update plugins and tools.

## What gets installed

**Plugins (via omz):** git, sudo, history-substring-search, dirhistory, nvm (lazy-loaded), docker, docker-compose, tailscale, zsh-autosuggestions, zsh-syntax-highlighting, fzf-tab, zsh-completions

**Tools:** fzf, zoxide, Oh My Posh

**Optional:** bat and eza for enhanced fzf previews (install separately, falls back gracefully without them)

## conf.d

`.zshrc` sources every `*.zsh` file in `conf.d/` in lexicographic order. Numbered prefixes guarantee load order. Gaps leave room to insert files without renumbering.

## Prompt

Custom Oh My Posh theme (`omp/danjam.omp.json`). Sky blue path and git info, teal SSH session, purple execution time, grey separators. Transient prompt collapses previous prompts to just the arrow.

## Keyboard shortcuts

| Shortcut | Action |
|---|---|
| Ctrl+T | Fuzzy file finder |
| Ctrl+R | Fuzzy history search |
| Alt+C | Fuzzy cd |
| Tab | fzf-tab completion (with previews) |
| Alt+Left/Right | Directory history |
| Alt+Up | Parent directory |
| Up/Down | History substring search |
| Esc Esc | Prepend sudo |

## Tmux

Config at `tmux/.tmux.conf`, symlinked to `~/.tmux.conf`. Prefix is `Ctrl+a`. Mouse support, 10k scrollback, true color, 1-based indexing, clean status bar.

## Local files (not tracked)

- `~/.secrets` — credentials (created from `.secrets.example`)
- `~/.zsh_aliases` — machine-local aliases
