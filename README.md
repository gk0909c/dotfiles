# my Vim dotfiles #
## usage ##

```bash
mkdir -p ~/dotfiles
git clone https://github.com/gk0909c/dotfiles.git ~/dotfiles/

mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vimrc_tab ~/.vimrc_tab
ln -sf ~/dotfiles/.snippet ~/.vim/my_snippet
ln -sf ~/dotfiles/ftplugin/ ~/.vim/ftplugin
```

after this commands, open vim and do Bundle Install

## memo ##
when colorscheme is not set on default, do this.  
I hava this problem on vagrant ubuntu 14.04.

```
echo "export TERM=xterm-256color" >> ~/.bashrc
```

for python,
```
pip install jedi
#or
git submodule update --init # in jedi-vim installed directory
```


