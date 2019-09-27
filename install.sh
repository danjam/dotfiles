#!/bin/bash

scriptdir="${0%/*}"
symlinks=( .zshrc .aliases .zsh_custom .config/terminator )

# check for zsh
if [ ! -n "`$SHELL -c 'echo $ZSH_VERSION'`" ];
then
  echo Exiting, ZSH  does not appear to be installed or is not the default shell
  exit 1
else
  echo Detected ZSH
fi

# symlink files
for symlink in ${symlinks[@]}
do
  if [ ! -e $HOME/$symlink ]
  then
    echo Linking $HOME/$symlink
    ln -s $scriptdir/$symlink $HOME/$symlink
  else
    echo \'$scriptdir/$symlink\' could not be linked as \'$HOME/$symlink\' already exists
  fi
done

# clone plugins
if [ ! -d $scriptdir/.zsh_custom/plugins/zsh-autosuggestions ] || [ -z "$(ls -A $scriptdir/.zsh_custom/plugins/zsh-autosuggestions)"  ]
then
  echo Cloning zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions $scriptdir/.zsh_custom/plugins/zsh-autosuggestions
else
  echo Cannot clone 'zsh-autosuggestions' as '$scriptdir/.zsh_custom/plugins/zsh-autosuggestions' already exists and is not empty
fi
