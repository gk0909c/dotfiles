#!/bin/bash

check_git_status() {
  git status | grep "$1" > /dev/null
  return $?
}

cd ~/dotfiles
git fetch origin master 2> /dev/null


check_git_status "and can be fast-forwarded"
can_fast_forward=$?

check_git_status "Changes not staged for commit"
have_not_stated_change=$?

check_git_status "Changes to be committed"
have_stated_change=$?

check_git_status "have diverged"
have_diverged=$?

if [ $have_diverged -eq 0 ]; then
  echo -e -n "\e[31m"
  echo "you have diverged on dotfiles repository."
  echo -n "check your status."
  echo -e "\e[m"
elif [ $can_fast_forward -eq 0 ]; then
  if [ $have_not_stated_change -eq 0 -o $have_stated_change -eq 0 ]; then
    echo -e -n "\e[31m"
    echo "remote dotfiles have been updated."
    echo "but you have local only change on dotfiles repository."
    echo -n "check your status."
    echo -e "\e[m"
  else
    git pull origin master
    echo ""
    echo "executed git pull on dotfiles repository"
  fi
fi
