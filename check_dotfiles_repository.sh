#!/bin/bash

# cd ~/dotfiles
cd ~/tmp/bbb/test-git-status
git fetch origin master 2> /dev/null


git status | grep "and can be fast-forwarded" > /dev/null
can_fast_forward=$?

git status | grep "Changes not staged for commit" > /dev/null
have_not_stated_change=$?

git status | grep "Changes to be committed" > /dev/null
have_stated_change=$?

git status | grep "have diverged" > /dev/null
have_diverged=$?

if [ $have_diverged -eq 0 ]; then
  echo -e -n "\e[31m"
  echo "you have diverged on dotfiles repository."
  echo -n "check your status."
  echo -e "\e[m"
elif [ $can_fast_forward -eq 0 ]; then
  if [ $have_not_stated_change -eq 0 -o $have_stated_change -eq 0 ]; then
    echo -e -n "\e[31m"
    echo "you have local only change on dotfiles repository."
    echo -n "check your status."
    echo -e "\e[m"
  else
    git pull origin master
    echo "execute git pull"
  fi
fi
