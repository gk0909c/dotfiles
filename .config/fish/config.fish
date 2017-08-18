set -x PATH $HOME/.linuxbrew/bin $PATH
set -x MANPATH $HOME/.linuxbrew/share/man $MANPATH
set -x INFOPATH $HOME/.linuxbrew/share/info $INFOPATH
rbenv init - | source
set -U fish_user_paths $fish_user_paths $HOME/.nodebrew/current/bin
pyenv init - | source

set -x TERM xterm-256color
