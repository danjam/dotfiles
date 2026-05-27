#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

if ! command -v zsh &>/dev/null; then
  echo "Error: zsh is not installed. Please install zsh and re-run."
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
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
  git -C "$HOME/.fzf" pull --ff-only && "$HOME/.fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish || echo "Warning: failed to update fzf, skipping"
else
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

if ! command -v oh-my-posh &>/dev/null; then
  echo "Installing Oh My Posh..."
  curl -s https://ohmyposh.dev/install.sh | bash
else
  echo "Oh My Posh already installed, skipping"
fi

if ! command -v zoxide &>/dev/null; then
  echo "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed, skipping"
fi

if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  echo "Backing up existing .zshrc to .zshrc.bak"
  cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
echo "Symlinked ~/.zshrc -> $DOTFILES/zsh/.zshrc"

ln -sf "$DOTFILES/nano/.nanorc" "$HOME/.nanorc"
echo "Symlinked ~/.nanorc -> $DOTFILES/nano/.nanorc"

ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
echo "Symlinked ~/.tmux.conf -> $DOTFILES/tmux/.tmux.conf"

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
