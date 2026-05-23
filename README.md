# Dotfiles

Zsh + Oh My Zsh, managed with symlinks and an idempotent install script.

## Setup

```bash
git clone git@github.com:danjam/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
exec zsh
```

Re-run `install.sh` to update plugins and tools.

## Layout

```
~/dotfiles/
  install.sh
  .secrets.example
  nano/
    .nanorc                          # symlinked to ~/.nanorc
  zsh/
    .zshrc                           # symlinked to ~/.zshrc
    conf.d/
      00-path.zsh                    # PATH, NVM_DIR, bun
      10-exports.zsh                 # environment variables
      20-options.zsh                 # shell options
      30-aliases.zsh                 # aliases
      40-functions.zsh               # functions
      45-fzf.zsh                     # fzf shell integration
      50-zoxide.zsh                  # zoxide init
      55-highlighting.zsh            # syntax-highlighting overrides
```

## conf.d

`.zshrc` sources every `*.zsh` file in `conf.d/` in lexicographic order. Numbered prefixes guarantee load order. Gaps leave room to insert files without renumbering.

## Plugins

**omz built-in:** git, sudo, history-substring-search, dirhistory, nvm (lazy-loaded)

**Third-party (cloned by install.sh):** zsh-autosuggestions, zsh-syntax-highlighting, fzf-tab, zsh-completions

**Tools (installed by install.sh):** fzf, zoxide

## Local files (not tracked)

- `~/.secrets` — credentials (created from `.secrets.example`)
- `~/.zsh_aliases` — machine-local aliases
