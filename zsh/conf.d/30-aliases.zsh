if command -v zoxide &>/dev/null; then
  alias cd='z'
  alias cdi='zi'
fi

if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
fi

if command -v eza &>/dev/null; then
  alias ls='eza'
  alias ll='eza -la --git --header'
else
  alias ll='ls -lhA'
fi

alias sysupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean'
