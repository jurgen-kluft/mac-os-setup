#!/usr/bin/env bash

#
# Make sure to enter your Git settings
#

if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Creating SSH key ..."
    # Copy this ssh key to github.com!
    ssh-keygen -t rsa -C "jurgen.kluft@gmail.com"
fi

echo "Setting Git configs ..."

user_name=$(git config --global user.name);
user_email=$(git config --global user.email);

if [[ "$user_name" != "" ]]; then
    echo "Username already set, aborting"
    exit 0
fi

if [[ "$user_email" != "" ]]; then
    echo "Email already set, aborting"
    exit 0
fi

unset user_name
unset user_email

# Set git config values
git config --global user.name "Jurgen Kluft"
git config --global user.email "jurgen.kluft@gmail.com"
git config --global github.user jurgen-kluft
git config --global github.token your_token_here
git config --global color.ui true
