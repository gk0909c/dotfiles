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
| nodebrew  | manage nodejs versions, installed via brew |
| pyenv     | manage python versions, installed via brew |

## basic settings
do below

```bash
sudo apt -y install build-essential curl git tree python-setuptools ruby bzip2 libreadline-dev libsqlite3-dev
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/linuxbrew/go/install)"

timedatectl set-timezone Asia/Tokyo

git config --global user.name "username"
git config --global user.email "your@email.com"
git config --global core.excludesfile ~/.gitignore

export PATH="$HOME/.linuxbrew/bin:$PATH"
# for linuxbrew bug
cd $(brew --prefix) && git fetch && git reset --hard origin/master
cd -

# install fish
~/dotfiles/install/fish.sh
# install rbenv, nodebrew, pyenv, and etc
~/dotfiles/install/other_software.sh
# create dot files synbolic links
~/dotfiles/dotfiles.sh

# setup remaining 
chsh -s /usr/bin\fish
fish
fisher
__fzf_install
~/dotfiles/install/set_ssh_key_for_github.fish
```

## install softwares
see in ./install directory, and exec each file

NOTE. 

+ need sudoers
+ when generating ssh key, the shell use email from git global user.email config
+ when setting ssh to github, the shell use proxy from $http_proxy environment variable.  
  if $http_proxy is not set, do nothing.


