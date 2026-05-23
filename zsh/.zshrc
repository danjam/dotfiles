export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="kafeitu"
zstyle ':omz:plugins:nvm' lazy yes
plugins=(git zsh-autosuggestions sudo history-substring-search dirhistory fzf-tab nvm zsh-completions)
plugins+=(zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

for conf in "$HOME/dotfiles/zsh/conf.d/"*.zsh(N); do
  source "$conf"
done

[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.secrets ]] && source ~/.secrets
