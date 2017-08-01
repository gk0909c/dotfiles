# dotfiles
my setting files

## using
I'm using below softwares.

| Software  | for                                        |
| ---       | ---                                        |
| fish      | shell environment                          |
| LinuxBrew | manage softwares                           |
| tmux      | terminal multiplexer                       |
| vim       | editor                                     |
| rbenv     | manage ruby versions,   installed via brew |
| nvm       | manage nodejs versions, installed directly |
| pyenv     | manage python versions, installed via brew |

## basic settings
do below

```bash
isudo apt install curl git tree
git config --global user.name "username"
git config --global user.email "your@email.com"

```

## install softwares
see in ./install directory, and exec each file

NOTE. 

+ need sudoers
+ when generating ssh key, the shell use email from git global user.email config
+ when setting ssh to github, the shell use proxy from $http_proxy environment variable.  
  if $http_proxy is not set, do nothing.

## environment setting
exec dotfiles.sh,

+ create symbolic link for vim, tmux, fish
+ exec install fzf

```bash
bash dotfiles.sh
```


