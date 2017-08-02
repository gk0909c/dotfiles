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

# nvm
wget https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh
bash install.sh
rm install.sh
fisher nvm
echo "set -x NVM_DIR $HOME/.nvm" >> ~/.config/fish/config.fish
. ~/.config/fish/config.fish
nvm install v6.11.1
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
