#!/usr/bin/env bash

#
# Installs dotfiles, making backups of files before overwriting
#

CURRENT_DIRECTORY="$( cd "$( dirname "$0" )" && pwd )"
FILES="
  bash_profile
  gitconfig
  gitignore
  oh-my-zsh
  tmux.conf
  vimrc
  zshrc
"
BACKUP_DIR=backup-$(date +"%Y%m%d_%H%M%S")

echo "Initialize git submodules"
git submodule update --init

echo "Linking dotfiles in $HOME/"
for file in $FILES
do
  echo "Processing $file"
  FROM=$CURRENT_DIRECTORY/$file
  TO=$HOME/.$file

  # backup existing files
  if [ -e $TO -a ! -h $TO ]; then
    echo -e "\t$TO exists, moved to $BACKUP_DIR/."
    mkdir -p $BACKUP_DIR
    mv $TO $BACKUP_DIR/
  fi;

  if [ -h $TO ]; then
    echo -e "\t$TO exists, as a symlink, no action."
  else
    echo -e "\tLink added - $FROM -> $TO"
    ln -s $FROM $TO
  fi;

done
