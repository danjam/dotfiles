# CLAUDE.md

Personal dotfiles repo. Zsh + Oh My Zsh on WSL2.

## Structure

- `zsh/.zshrc` is symlinked to `~/.zshrc` — keep it minimal (omz setup, conf.d loop, secrets source)
- `zsh/conf.d/*.zsh` files are sourced in order by numbered prefix
- `nano/.nanorc` is symlinked to `~/.nanorc`
- `~/.secrets` holds credentials and is never committed
- `~/.zsh_aliases` holds machine-local aliases and is never committed
- `install.sh` automates setup and updates — idempotent, safe to re-run anytime

## conf.d layout

- `00-path.zsh` — PATH, NVM_DIR, bun
- `10-exports.zsh` — environment variables
- `20-options.zsh` — shell options (WSL auto-cd to ~)
- `45-fzf.zsh` — fzf shell integration
- `50-zoxide.zsh` — zoxide init (guarded)
- `55-highlighting.zsh` — syntax-highlighting style overrides

## Plugins

**Built-in omz:** git, sudo, history-substring-search, dirhistory, nvm (lazy-loaded)

**Third-party (cloned by install.sh):** zsh-autosuggestions, zsh-syntax-highlighting, fzf-tab, zsh-completions

**zsh-syntax-highlighting must be last** — loaded via `plugins+=()` on a separate line.

**zsh-completions** needs its fpath set before compinit — the omz plugins array handles this, but check fpath ordering if completions break.

## External tools (installed by install.sh)

- **fzf** — cloned to `~/.fzf`, provides Ctrl+R/Ctrl+T/Alt+C
- **zoxide** — installed to `~/.local/bin`, provides `z`/`zi` commands

## Rules

- Never commit credentials, API keys, or tokens — those go in `~/.secrets`
- Never use `sed -i` on dotfiles — use the Edit tool or write the file directly
- Back up any file before replacing or deleting it
- Test changes by launching a new zsh shell (`zsh -i -c '...'`) before claiming they work
- Keep `.zshrc` thin — put config in the appropriate `conf.d/` file
- When adding third-party plugins, add them to both `.zshrc` plugins array and `install.sh` plugins array
- When adding external tools, guard their init in conf.d with `command -v` so dotfiles work on machines without them
- When adding new config files, follow the `tool/.configfile` directory convention (e.g. `nano/.nanorc`, `zsh/.zshrc`)
