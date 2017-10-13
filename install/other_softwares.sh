#!/bin/bash

# git
brew install git

# vim
brew install lua
brew install python3
brew install vim --with-python3 --with-lua


# tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ruby
sudo apt -y install zlib1g-dev
brew install rbenv
rbenv install 2.4.1

# nodebrew
brew install nodebrew
mkdir -p ~/.nodebrew/src
nodebrew install-binary v6.11.2
nodebrew use v6.11.2
npm update -g npm

# python
sudo apt -y install libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
brew install pyenv
pyenv install 3.6.2
pyenv global 3.6.2

# others
brew install ctags
