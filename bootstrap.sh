#!/bin/bash

if ! [ -x "$(command -v brew)" ]; then
  echo "Install brew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
fi

if ! [ -x "$(command -v ansible-playbook)" ]; then
  echo "Install ansible"
  brew install ansible
fi

echo "Play ansible playbook"
ansible-playbook -i "localhost," -c local playbook.yml
