command -v fzf &>/dev/null && eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="--color=info:yellow:reverse --preview-window='border-line'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range :300 {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'eza -la --git --color=always {} 2>/dev/null || ls {}'"

# Disable default menu so fzf-tab takes over
zstyle ':completion:*' menu no
# Case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:*' fzf-flags --color=info:yellow:reverse --preview-window='border-line'
zstyle ':fzf-tab:*' fzf-min-height 20
zstyle ':fzf-tab:complete:(cd|z|zi):*' fzf-preview 'eza -la --git --color=always $realpath 2>/dev/null || ls $realpath'
zstyle ':fzf-tab:complete:(cat|bat|less|head|tail|nano|vim):*' fzf-preview 'bat --color=always --style=numbers --line-range :50 $realpath 2>/dev/null || cat $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:(kill|pkill|ps):argument-rest' fzf-preview 'ps -p $word -o pid,user,%cpu,%mem,cmd --no-headers 2>/dev/null'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'git log --color=always --oneline -20 $word 2>/dev/null'
zstyle ':fzf-tab:complete:git-add:*' fzf-preview 'git diff --color=always --stat $word 2>/dev/null; echo; git diff --color=always $word 2>/dev/null | tail -n +5'
