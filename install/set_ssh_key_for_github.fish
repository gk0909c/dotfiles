#!/usr/bin/fish

cd ~/.ssh
set -l user_email (git config --list | grep email | string replace 'user.email=' '')
ssh-keygen -t rsa -f ./id_rsa -N "" -C $user_email

# regist public key to gihub and etc...
echo 'Host github.com' >> ~/.ssh/config
echo '  HostName ssh.github.com' >> ~/.ssh/config
echo '  IdentityFile ~/.ssh/id_rsa' >> ~/.ssh/config
echo '  port 443' >> ~/.ssh/config
echo '  User git' >> ~/.ssh/config 

if test -n $http_prox
  set -l proxy_str (string replace 'http://' '' $http_proxy)
  echo "  ProxyCommand nc -X connect -x $proxy_str %h %p" >> ~/.ssh/config
end

# confirm
echo 'do below command for confirm "ssh -T git@github.com"'

