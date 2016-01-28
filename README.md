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

## memo ##
when colorscheme is not set on default, do this.  
I hava this problem on vagrant ubuntu 14.04.
```
echo "export TERM=xterm-256color" >> ~/.bashrc
```
