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

  brew cask install \
    java

  # Install homebrew packages
  echo "brew install"
  brew install \
    ansible \
    fasd \
    gibo \
    git \
    gradle \
    node \
    nvm \
    perl \
    python \
    reattach-to-user-namespace \
    ruby \
    tmux \
    tree \
    zsh \
    wget

  # Install homebrew casks
  echo "brew cask install"
  brew cask install \
    atom \
    datagrip \
    docker \
    firefox \
    google-chrome \
    intellij-idea \
    iterm2 \
    lastpass \
    libreoffice \
    lighttable \
    meld \
    openemu \
    pycharm \
    rectangle \
    rubymine \
    slack \
    spotify \
    tcl \
    vagrant \
    virtualbox

  echo "brew update"
  brew update

  echo "brew upgrade --all"
  brew upgrade

  echo "brew cleanup"
  brew cleanup

  # TODO: install rvm or rbenv and remove sudo
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

  # Install cpan dependencies
  echo "install Crypt::HSXKPasswd"
  cpan Crypt::HSXKPasswd

else
  echo "Unsupported OS! (for now)"
fi

exit 0
