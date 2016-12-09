@echo off

IF NOT EXIST %HOMEPATH%"\.vim\dein" (
  mkdir %HOMEPATH%"\.vim\dein\repos\github.com\Shougo"
  git clone https://github.com/Shougo/dein.vim.git %HOMEPATH%"\.vim\dein\repos\github.com\Shougo\dein.vim"
)

mklink %HOMEPATH%"\_vimrc" %HOMEPATH%"\dotfiles\.vimrc"
mklink %HOMEPATH%"\_gvimrc" %HOMEPATH%"\dotfiles\.gvimrc"
mklink %HOMEPATH%"\.vrapperrc" %HOMEPATH%"\dotfiles\.vrapperrc"

mklink %HOMEPATH%"\.vim\plugins.toml" %HOMEPATH%"\dotfiles\.vim\plugins.toml"
mklink %HOMEPATH%"\.vim\plugins_lazy.toml" %HOMEPATH%"\dotfiles\.vim\plugins_lazy.toml"

mklink %HOMEPATH%"\.vim\vimpreview.css" %HOMEPATH%"\dotfiles\.vim\vimpreview.css"

mklink /D %HOMEPATH%"\vimfiles\autoload" %HOMEPATH%"\dotfiles\.vim\autoload"
mklink /D %HOMEPATH%"\.vim\dict" %HOMEPATH%"\dotfiles\.vim\dict"
mklink /D %HOMEPATH%"\.vim\snippets" %HOMEPATH%"\dotfiles\.vim\snippets"

pause
exit 0
