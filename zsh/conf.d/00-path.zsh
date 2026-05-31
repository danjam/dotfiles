path=(
  $HOME/.local/bin
  $path
)
[[ -d /opt/homebrew/bin ]] && path=(/opt/homebrew/bin $path)
# Deduplicate PATH entries
typeset -U PATH path
