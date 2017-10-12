#!/usr/bin/fish

wget https://packages.chef.io/files/stable/chefdk/2.3.4/ubuntu/16.04/chefdk_2.3.4-1_amd64.deb
sudo dpkg -i chefdk_2.3.4-1_amd64.deb
chef gem install knife-solo -v 0.7.0.pre
chef gem install kitchen-docker

rm chefdk_2.3.4-1_amd64.deb

