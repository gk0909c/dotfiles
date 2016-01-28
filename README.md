# my Vim dotfiles #
## usage ##

```bash
mkdir -p ~/dotfiles
git clone https://github.com/satk0909/dotfiles.git ~/dotfiles/

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vimrc_tab ~/.vimrc_tab
ln -sf ~/dotfiles/.snippet ~/.vimrc_snippet

mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
```

after this commands, open vim and do Bundle Install

