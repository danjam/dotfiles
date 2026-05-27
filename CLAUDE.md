# CLAUDE.md

Personal dotfiles repo. Zsh + Oh My Zsh on WSL2/macOS.

## Structure

- `zsh/.zshrc` is symlinked to `~/.zshrc` — keep it minimal (omz setup, conf.d loop, secrets source)
- `zsh/conf.d/*.zsh` files are sourced in order by numbered prefix
- `omp/danjam.omp.json` — Oh My Posh prompt theme
- `nano/.nanorc` is symlinked to `~/.nanorc`
- `tmux/.tmux.conf` is symlinked to `~/.tmux.conf`
- `~/.secrets` holds credentials and is never committed
- `~/.zsh_aliases` holds machine-local aliases and is never committed
- `~/.zsh_local` holds machine-local environment (PATH, exports) and is never committed
- `install.sh` automates setup and updates — idempotent, safe to re-run anytime

## conf.d layout

- `00-path.zsh` — PATH, bun
- `10-exports.zsh` — environment variables (EDITOR, LESS)
- `20-options.zsh` — shell options (WSL auto-cd to ~)
- `30-aliases.zsh` — aliases (ll uses eza when available)
- `40-functions.zsh` — custom functions
- `45-fzf.zsh` — fzf shell integration, previews, fzf-tab config
- `50-zoxide.zsh` — zoxide init (guarded)
- `55-highlighting.zsh` — syntax-highlighting style overrides

## Plugins

**Built-in omz:** git, sudo, history-substring-search, dirhistory, docker, docker-compose, tailscale

**Third-party (cloned by install.sh):** zsh-autosuggestions, zsh-syntax-highlighting, fzf-tab, zsh-completions

**zsh-syntax-highlighting must be last** — loaded via `plugins+=()` on a separate line.

**Plugin pre-config goes in `.zshrc`** not conf.d — it must be set before omz loads (e.g. autosuggest strategy).

## External tools (installed by install.sh)

- **fzf** — cloned to `~/.fzf`, provides Ctrl+R/Ctrl+T/Alt+C
- **zoxide** — installed to `~/.local/bin`, provides `z`/`zi` commands
- **Oh My Posh** — installed to `~/.local/bin`, prompt theme engine

## Optional tools (not installed by install.sh)

- **bat** — syntax-highlighted file previews in fzf (falls back to cat)
- **eza** — enhanced directory listings in fzf and ll alias (falls back to ls)

## Rules

- Never commit credentials, API keys, or tokens — those go in `~/.secrets`
- Never use `sed -i` on dotfiles — use the Edit tool or write the file directly
- Back up any file before replacing or deleting it
- Test changes by launching a new zsh shell (`zsh -i -c '...'`) before claiming they work
- Keep `.zshrc` thin — put config in the appropriate `conf.d/` file
- When adding third-party plugins, add them to both `.zshrc` plugins array and `install.sh` plugins array
- When adding external tools, guard their init in conf.d with `command -v` so dotfiles work on machines without them
- When adding new config files, follow the `tool/.configfile` directory convention (e.g. `nano/.nanorc`, `zsh/.zshrc`)
- No backslash line continuations in shell config — keep each command on a single line
