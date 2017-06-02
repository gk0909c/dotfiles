# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# base setting
source ~/.bash_base

# about ruby
if type rbenv >/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# about python
if type pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# about nodejs
if type nvm >/dev/null 2>&1; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# about docker
function docker-build() {
  if [ -v http_proxy ]; then
    docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy -t $1 $2
  else
    docker build -t $1 $2
  fi
}

# grep sjis file
function grepSjis() {
  if [ $# -ne 2 ]; then
    echo "specify 2 arguments"
    return
  fi

  grep -n $1 $2 | nkf -w | grep --color $1
}

# others
export TERM=xterm-256color

# alias
source ~/.my_aliases.sh
