#!/bin/sh

# Ask for the administrator password upfront
sudo -v

if [ ! $(xcode-select -p) ]
then
  xcode-select --install
fi

if [ ! $(which javac) ]
then
  echo "Install Java JDK"
  exit
fi

if [ "$(uname -s)" == "Darwin" ]
then
  echo "Updating Mac OS X."
  softwareupdate --install --all

  # Check for Homebrew
  if [ ! $(which brew) ]
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
    packer \
    maven \
    mono \
    tmux \
    docker \
    docker-machine \
    docker-swarm \
    docker-compose \
    ansible \
    caskroom/cask/brew-cask

  # Install homebrew casks
  # brew cask install \
    # virtualbox \
    # vagrant \
    # xquartz \
    # keepassx \
    # sizeup \
    # vlc \
    # atom

  echo "brew update"
  brew update

  echo "brew upgrade --all"
  brew upgrade

  echo "brew cleanup"
  brew cleanup

  if [ ! $(which tmuxinator) ]
  then
    echo "Installing gems"
    sudo gem install tmuxinator
  else
    echo "Updating gems"
    sudo gem update
  fi

  if [ -e /Volumes/Workspace ]
  then
    if [ ! -e ~/Workspace ]
    then
      ln -s /Volumes/Workspace ~/Workspace
      mkdir -p ~/Workspace/repos/github/schultzy51
    fi
  fi

else
  echo "Unsupported OS! (for now)"
fi

exit 0
