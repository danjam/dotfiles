# Dotfiles

Danny's dotfiles. WSL2 (Ubuntu on Windows), zsh with Oh My Zsh.

## Setup

```bash
git clone git@github.com:danjam/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
# Edit ~/.secrets with actual values
exec zsh
```

## Layout

```
~/dotfiles/
  install.sh                         # automated setup
  .secrets.example                   # template for ~/.secrets
  .gitignore
  zsh/
    .zshrc                           # thin loader — symlinked to ~/.zshrc
    conf.d/
      00-path.zsh                    # PATH entries, NVM, bun setup
      10-exports.zsh                 # non-secret environment variables
      20-options.zsh                 # setopt, history config
      30-aliases.zsh                 # shell aliases
      40-functions.zsh               # custom shell functions

~/.zshrc          -> ~/dotfiles/zsh/.zshrc       # symlink
~/.secrets                                       # API keys — never committed
```

## How It Works

### The Loader

`.zshrc` sets up Oh My Zsh, sources every `*.zsh` file in `conf.d/` in order, then sources `~/.secrets`.

The `(N)` glob qualifier (nullglob) means the loop is skipped instead of erroring if `conf.d/` is empty.

### conf.d

Files are sourced in lexicographic order. Numbered prefixes guarantee load order:

| File | Purpose |
|------|---------|
| `00-path.zsh` | PATH additions, NVM, bun, Go |
| `10-exports.zsh` | Non-secret env vars (LESS, MILVUS_ADDRESS) |
| `20-options.zsh` | Shell options, history settings |
| `30-aliases.zsh` | Shell aliases |
| `40-functions.zsh` | Custom functions |

Gaps (00, 10, 20...) leave room to insert files without renumbering.

### Secrets

`~/.secrets` holds API keys, tokens, and credentials. One per machine, never committed. The test: would you paste it in a public GitHub repo? If no, it goes in `~/.secrets`.

### Plugins

Third-party plugins are installed into `~/.oh-my-zsh/custom/plugins/` by `install.sh`. Add the plugin name to the `plugins=()` array in `.zshrc`.

Currently installed: `git`, `zsh-autosuggestions`, `sudo`.
