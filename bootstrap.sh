#!/bin/bash

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
ansible-playbook -i "localhost," -D -c local --ask-become-pass playbook.yml -vvvv
