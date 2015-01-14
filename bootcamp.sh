#!/bin/sh

#install Xcode
#install Google Chrome
#install Hipchat
#install Big IP Edge Client (f5)
#install Atom
#install BitTorrent Sync
#install SizeUp

# Ask for the administrator password upfront
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then
  echo "Updating Mac OS X."
  softwareupdate --install --all

  # Check for Homebrew
  if test ! $(which brew)
  then
    echo "  Installing Homebrew for you."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "brew doctor"
  brew doctor

  echo "brew tap"
  brew tap homebrew/binary
  brew tap homebrew/x11

  # Install homebrew packages
  echo "brew install"
  brew install \
    wget \
    gradle \
    git \
    tree \
    zsh \
    reattach-to-user-namespace \
    gibo \
    ansible \
    meld \
    packer

  echo "brew update"
  brew update

  echo "brew upgrade"
  brew upgrade

  echo "brew cleanup"
  brew cleanup

  if test ! $(which tmuxinator)
  then
    echo "  Installing gems"
    gem install tmuxinator
  else
    echo "  Updating gems"
    gem update
  fi

  if [ -e /Volumes/Workspace ]
  then
    if [ ! -e ~/Workspace ]
    then
      ln -s /Volumes/Workspace ~/Workspace
      mkdir -p ~/Workspace/repos/github/schultzy51
      mkdir -p ~/Workspace/btsync/backup
    fi
  fi

else
  echo "Unsupported OS! (for now)"
fi

exit 0
