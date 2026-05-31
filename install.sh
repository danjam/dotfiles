#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

if ! command -v zsh &>/dev/null; then
  echo "Error: zsh is not installed. Please install zsh and re-run."
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  # RUNZSH=no: don't launch zsh after install; KEEP_ZSHRC=yes: don't overwrite our .zshrc
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

plugins=(
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting"
  "Aloxaf/fzf-tab"
  "zsh-users/zsh-completions"
)

for plugin in "${plugins[@]}"; do
  name="${plugin##*/}"
  dest="$ZSH_CUSTOM/plugins/$name"
  if [ -d "$dest" ]; then
    echo "Updating $name..."
    git -C "$dest" pull --ff-only || echo "Warning: failed to update $name, skipping"
  else
    echo "Installing $name..."
    git clone "https://github.com/$plugin" "$dest"
  fi
done

if [ -d "$HOME/.fzf" ]; then
  echo "Updating fzf..."
  git -C "$HOME/.fzf" pull --ff-only && "$HOME/.fzf/install" --bin || echo "Warning: failed to update fzf, skipping"
else
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  # --bin: binary only, shell integration comes from `fzf --zsh` in conf.d
  "$HOME/.fzf/install" --bin
fi

echo "Installing/updating Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash

echo "Installing/updating zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

link_dotfile() {
  [ -e "$2" ] && [ ! -L "$2" ] && { cp "$2" "$2.bak"; echo "Backed up $2 -> $2.bak"; }
  ln -sf "$1" "$2"
  echo "Symlinked $2 -> $1"
}

link_dotfile "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link_dotfile "$DOTFILES/nano/.nanorc" "$HOME/.nanorc"
link_dotfile "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Ensuring XDG directories exist..."
mkdir -p "$HOME/.local/state/zsh" "$HOME/.local/state/less" "$HOME/.local/state/wget" "$HOME/.cache/zsh"

if [ ! -f "$HOME/.zsh_aliases" ]; then
  cat > "$HOME/.zsh_aliases" <<'EOF'
# Machine-local aliases — this file is sourced by .zshrc but not tracked in dotfiles.
# Add aliases specific to this machine here.
EOF
  echo "Created ~/.zsh_aliases for machine-local aliases"
else
  echo "~/.zsh_aliases already exists, skipping"
fi

if [ ! -f "$HOME/.zsh_local" ]; then
  cat > "$HOME/.zsh_local" <<'EOF'
# Machine-local environment — this file is sourced by .zshrc but not tracked in dotfiles.
# Add PATH entries, exports, and other config specific to this machine here.
EOF
  echo "Created ~/.zsh_local for machine-local environment"
else
  echo "~/.zsh_local already exists, skipping"
fi

if [ ! -f "$HOME/.secrets" ]; then
  cp "$DOTFILES/.secrets.example" "$HOME/.secrets"
  chmod 600 "$HOME/.secrets"
  echo "Created ~/.secrets from template — edit it with your actual values"
else
  echo "~/.secrets already exists, skipping"
fi

optional=()
command -v bat &>/dev/null || optional+=(bat)
command -v eza &>/dev/null || optional+=(eza)
if [ ${#optional[@]} -gt 0 ]; then
  echo ""
  echo "For enhanced fzf previews, consider installing: ${optional[*]}"
fi

echo ""
echo "Done. Run 'exec zsh' to reload."
