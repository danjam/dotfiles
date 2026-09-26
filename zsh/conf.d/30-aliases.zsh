# Claude Code (CLAUDECODE=1) runs commands through this shell, so keep standard commands standard

if command -v zoxide &>/dev/null; then
  [[ -z $CLAUDECODE ]] && alias cd='z'
  alias cdi='zi'
fi

if command -v bat &>/dev/null && [[ -z $CLAUDECODE ]]; then
  alias cat='bat --paging=never'
fi

if command -v eza &>/dev/null; then
  [[ -z $CLAUDECODE ]] && alias ls='eza'
  alias ll='eza -la --git --header'
else
  alias ll='ls -lhA'
fi

[[ -n $CLAUDECODE ]] && unalias grep egrep fgrep 2>/dev/null

alias sysupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean'
