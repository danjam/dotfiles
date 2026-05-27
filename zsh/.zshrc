[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
DOTFILES="$HOME/dotfiles"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
plugins=(git zsh-autosuggestions sudo history-substring-search dirhistory fzf-tab zsh-completions docker docker-compose tailscale)
# zsh-syntax-highlighting must be last
plugins+=(zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

for conf in "$DOTFILES/zsh/conf.d/"*.zsh(N); do
  source "$conf"
done

command -v oh-my-posh &>/dev/null && eval "$(oh-my-posh init zsh --config "$DOTFILES/omp/danjam.omp.json")"

[[ -f ~/.secrets ]] && source ~/.secrets
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_local ]] && source ~/.zsh_local
