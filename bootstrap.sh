#!/bin/bash

# Check if console tools installed
if ! xcode-select -p>/dev/null; then
  echo "Install xcode"
  xcode-select --install
  read -p "Press [Enter] when install finished..."
fi

if [ -x "$(command -v git)" ]; then
  git status | grep 'invalid active developer path' &> /dev/null
  echo "$?"
  if [ $? == 0 ]; then
    echo "Reinstall xcode"
    xcode-select --install
    wait
  fi
fi

# Install brew
if ! [ -x "$(command -v brew)" ]; then
  echo "Install brew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
fi

echo "Install latest ansible release"
if ! [ -x "$(command -v ansible-playbook)" ]; then
  brew install ansible
else
  brew upgrade ansible
fi

echo "Play ansible playbook"
if [ -z $1 ]; then
  ansible-playbook -i "localhost," -D -c local playbook.yml -vvvv
else
  ansible-playbook -i "localhost," -D -c local playbook.yml -vvvv --tags $1
fi
