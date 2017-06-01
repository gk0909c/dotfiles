#!/bin/bash

if [ ! -d  ~/.vim/dein ]; then
  mkdir -p ~/.vim/dein/repos/github.com/Shougo/
  git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
fi

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc

ln -sf ~/dotfiles/.vim/plugins.toml ~/.vim/
ln -sf ~/dotfiles/.vim/plugins_lazy.toml ~/.vim/

ln -sf ~/dotfiles/.vim/vimpreview.css ~/.vim/

ln -sf ~/dotfiles/.vim/autoload/ ~/.vim/
ln -sf ~/dotfiles/.vim/dict/ ~/.vim/
ln -sf ~/dotfiles/.vim/snippets/ ~/.vim/

ln -sf ~/dotfiles/.bashrc ~/
ln -sf ~/dotfiles/.bash_base ~/
ln -sf ~/dotfiles/.my_aliases.sh ~/

