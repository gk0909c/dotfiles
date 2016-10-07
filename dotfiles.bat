@echo off

IF NOT EXIST %HOMEPATH%"\.vim\bundle" (
  mkdir %HOMEPATH%"\.vim\bundle"
  git clone https://github.com/Shougo/neobundle.vim.git %HOMEPATH%"\.vim\bundle\neobundle.vim"
)

mklink %HOMEPATH%"\_vimrc" %HOMEPATH%"\dotfiles\.vimrc"
mklink %HOMEPATH%"\_gvimrc" %HOMEPATH%"\dotfiles\.gvimrc"
mklink %HOMEPATH%"\.vrapperrc" %HOMEPATH%"\dotfiles\.vrapperrc"

mklink /D %HOMEPATH%"\vimfiles\autoload" %HOMEPATH%"\dotfiles\.vim\autoload"
mklink /D %HOMEPATH%"\.vim\dict" %HOMEPATH%"\dotfiles\.vim\dict"
mklink /D %HOMEPATH%"\.vim\snippets" %HOMEPATH%"\dotfiles\.vim\snippets"

pause
exit 0
