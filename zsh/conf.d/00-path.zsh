path=(
  $HOME/.local/bin
  /usr/local/go/bin
  $path
)
[[ -d /opt/homebrew/bin ]] && path=(/opt/homebrew/bin $path)
typeset -U PATH path

export BUN_INSTALL="$HOME/.bun"
path=($BUN_INSTALL/bin $path)
