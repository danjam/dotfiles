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


#ln -s ~/.dotfiles/.zshrc ~/.zshrc
#ln -s ~/.dotfiles/.aliases ~/.aliases
#ln -s ~/.dotfiles/.zsh_custom ~/.zsh_custom

