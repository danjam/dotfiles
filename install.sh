#!/bin/bash

homedir=$HOME
scriptdir="${0%/*}"

symlinks=( .zshrc .aliases .zsh_custom .config/terminator )

for symlink in ${symlinks[@]}
do
  if [ ! -L $HOME/$symlink ]
  then
    echo Linking $HOME/$symlink
    ln -s $scriptdir/$symlink $HOME/$symlink
  else
    echo \'$scriptdir/$symlink\' could not be linked as \'$HOME/$symlink\' already exists
  fi
done

if [ ! -d $scriptdir/.zsh_custom/plugins/zsh-autosuggestions ] || [ -z "$(ls -A $scriptdir/.zsh_custom/plugins/zsh-autosuggestions)"  ]
then
  echo Cloning zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions $scriptdir/.zsh_custom/plugins/zsh-autosuggestions
else
  echo Cannot clone 'zsh-autosuggestions' as '$scriptdir/.zsh_custom/plugins/zsh-autosuggestions' already exists and is not empty
fi
