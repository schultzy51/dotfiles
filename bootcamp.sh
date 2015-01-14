#!/bin/sh

#install Xcode
#install Google Chrome
#install Hipchat
#install Big IP Edge Client (f5)
#install Atom
#install BitTorrent Sync
#install SizeUp

echo "Updating Mac OS X."
softwareupdate --install --all

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew doctor

# Install homebrew packages
brew install \
  wget \
  gradle \
  git \
  tree \
  zsh \
  reattach-to-user-namespace \
  gibo \
  ansible

if [ -e /Volumes/Workspace ]
then
  if [ ! -e ~/Workspace ]
  then
    ln -s /Volumes/Workspace ~/Workspace
    mkdir -p ~/Workspace/repos/github/schultzy51
    mkdir -p ~/Workspace/btsync/backup
  fi
fi

exit 0
