#!/bin/bash

# Check if console tools installed
# if [[ "$OSTYPE" == "darwin"* ]]; then
#   if ! xcode-select -p>/dev/null; then
#     echo "Install xcode"
#     xcode-select --install
#     read -p "Press [Enter] when install finished..."
#   fi
#
#   # Install brew
#   if ! [ -x "$(command -v brew)" ]; then
#     echo "Install brew"
#     ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#     brew update
#   fi
#
#   echo "Install latest ansible release"
#   if ! [ -x "$(command -v ansible-playbook)" ]; then
#     brew install ansible
#   else
#     brew upgrade ansible
#   fi
# elif [[ "$OSTYPE" == "linux-gnu" ]]; then
#   if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
#     sudo apt-add-repository ppa:ansible/ansible -y
#   fi
#   if ! hash ansible >/dev/null 2>&1; then
#     sudo apt-get update
#     sudo apt-get install -y software-properties-common ansible git python-apt
#   fi
# fi


echo "Play ansible playbook"
if [ -z $1 ]; then
  ansible-playbook -i "localhost," -D -c local playbook.yml --ask-become-pass -vvvv
else
  # ansible-playbook -i "localhost," -D -c local playbook.yml --ask-become-pass -vvvv --tags $1
  ansible-playbook -i "localhost," -D -c local playbook.yml  -vvvv --tags $1
fi
