#!/bin/sh

if [ ! -L ~/.zshrc ]; then
  ln -s ~/.dotfiles/.zshrc ~/.zshrc
fi

if [ ! -L ~/.aliases ]; then
  ln -s ~/.dotfiles/.aliases ~/.aliases
fi

if [ ! -L ~/.zsh_custom ]; then
  ln -s ~/.dotfiles/.zsh_custom ~/.zsh_custom
fi

if [ ! -L ~/.config/terminator ]; then
  ln -s ~/.dotfiles/.config/terminator ~/.config/terminator
fi

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.dotfiles/.zsh_custom/plugins/zsh-autosuggestions
