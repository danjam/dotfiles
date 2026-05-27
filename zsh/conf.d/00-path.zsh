path=(
  $HOME/.local/bin
  $path
)
[[ -d /opt/homebrew/bin ]] && path=(/opt/homebrew/bin $path)
typeset -U PATH path
