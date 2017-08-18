#!/usr/bin/env fish

# git
brew install git

# vim
brew install lua
brew install vim --with-lua

# tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ruby
sudo apt install zlib1g-dev
brew install rbenv
echo 'rbenv init - | source' >> ~/.config/fish/config.fish
. ~/.config/fish/config.fish
rbenv install 2.4.1

# nodebrew
brew install nodebrew
mkdir -p ~/.nodebrew/src
nodebrew install-binary v6.11.2
nodebrew use v6.11.2
echo 'set -U fish_user_paths $fish_user_paths $HOME/.nodebrew/current/bin' >> ~/.config/fish/config.fish 
. ~/.config/fish/config.fish
npm update -g npm

# python
sudo apt install libssl-dev
brew install pyenv
echo 'pyenv init - | source' >> ~/.config/fish/config.fish
. ~/.config/fish/config.fish
pyenv install 3.6.2
pyenv global 3.6.2

# others
brew install ctags
