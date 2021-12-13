#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ ! $(xcode-select -p) ]
then
  xcode-select --install
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

  echo "brew install languages"
  brew install \
    java \
    node \
    perl \
    python \
    ruby

  echo "brew install git tools"
  brew install \
    gibo \
    git \
    git-gui

  echo "brew install build tools"
  brew install \
    gradle \
    nvm

  echo "brew install other"
  brew install \
    fasd \
    reattach-to-user-namespace \
    tmux \
    tree \
    zsh \
    wget

  echo "brew install jetbrains tools"
  brew install \
    datagrip \
    intellij-idea \
    pycharm \
    rubymine

  echo "brew install editing tools"
  brew install \
    atom \
    iterm2 \
    meld \

  echo "brew cask install browsers"
  brew install \
    firefox \
    google-chrome

  echo "brew cask install vm tools"
  brew install \
    docker \
    virtualbox

  echo "brew cask install other"
  brew install \
    lastpass \
    libreoffice \
    lighttable \
    openemu \
    rectangle \
    slack \
    spotify

  echo "brew update"
  brew update

  echo "brew upgrade --all"
  brew upgrade

  echo "brew cleanup"
  brew cleanup

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
