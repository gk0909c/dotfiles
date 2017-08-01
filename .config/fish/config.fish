set -x PATH $HOME/.linuxbrew/bin $PATH
set -x MANPATH $HOME/.linuxbrew/share/man $MANPATH
set -x INFOPATH $HOME/.linuxbrew/share/info $INFOPATH
rbenv init - | source
pyenv init - | source
set -x NVM_DIR $HOME/.nvm

set -x TERM xterm-256color
