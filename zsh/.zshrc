# Homebrew completions (macOS)
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)
DOTFILES="$HOME/dotfiles"
export ZSH="$HOME/.oh-my-zsh"
# Disabled — Oh My Posh handles the prompt
ZSH_THEME=""
# Must be set before omz loads the plugin
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
plugins=(git zsh-autosuggestions sudo history-substring-search dirhistory fzf-tab zsh-completions docker docker-compose tailscale)
# zsh-syntax-highlighting must be last — it hooks into the line editor
plugins+=(zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# conf.d files are sourced in order by numbered prefix (00, 10, 20...)
for conf in "$DOTFILES/zsh/conf.d/"*.zsh(N); do
  source "$conf"
done

# Oh My Posh must init after omz to override the prompt
[[ -x "$HOME/.local/bin/oh-my-posh" ]] && eval "$(oh-my-posh init zsh --config "$DOTFILES/omp/danjam.omp.json")"

# Machine-local files — not tracked in dotfiles
[[ -f ~/.secrets ]] && source ~/.secrets
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_local ]] && source ~/.zsh_local

# Warn if an installer modified this file (interactive shells only)
[[ -o interactive ]] && { git -C "$DOTFILES" diff --quiet zsh/.zshrc 2>/dev/null || print -P "%F{red}Warning: .zshrc has local changes — if this is due to installer additions, move them to ~/.zsh_local%f"; }

# --- END OF CONFIG --- Anything below was added by an installer and should be moved to ~/.zsh_local
