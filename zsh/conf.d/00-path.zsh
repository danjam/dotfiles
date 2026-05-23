path=(
  $HOME/.local/bin
  /usr/local/go/bin
  $path
)
typeset -U PATH path

export NVM_DIR="$HOME/.nvm"

export BUN_INSTALL="$HOME/.bun"
path=($BUN_INSTALL/bin $path)
