# base setting
source ~/.bash_base

# about ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# about python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# about nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# about docker
function docker-build() {
  if [ -v http_proxy ]; then
    docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$http_proxy -t $1 $2
  else
    docker build -t $1 $2
  fi
}

# project helper
alias publish-istanbul="light-server -s ./coverage/lcov-report -p 3000 -b 0.0.0.0"
alias publish-jsdoc="light-server -s ./jsdoc -p 3000 -b 0.0.0.0"
alias publish-simplecov="light-server -s ./coverage -p 3000 -b 0.0.0.0"

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
