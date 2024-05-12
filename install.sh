#!/usr/bin/env bash

#
# Inspirations came from all over the fantastic .dotfiles repos at GitHub!
#

## Custom color codes & utility functions
source helpers/utility.sh

# Ask the user a Yes/No question
function ask_question() {
    read -p "${1} (y/N) " choice
    case "$choice" in
        Y | y | Yes | YES | yes ) return 0; exit;;
        N | n | No | NO | no ) return 1; exit;;
        * ) return 2;;
    esac
}

# Get the dotfiles directory's absolute path
MACOS_SETUP_DIR="$(cd "$(dirname "$0")"; pwd -P)"

# Pull latest files from GitHub
if ask_question 'Do you want to get latest?'; then
    echo "Fetching latest version from GitHub ..."

    cd "$MACOS_SETUP_DIR"
    git pull origin master
fi

# -------------------------------------------------------------------------------------------

# Install all software not bundled in Homebrew
if ask_question 'Do you want to install un-brewed software?'; then
    echo "Installing un-brewed software ..."
    for i in ./installer/*; do
        echo "Executing $i ..."
        sh "$i"
    done
fi

# -------------------------------------------------------------------------------------------

# Install all homebrew supported software
if ask_question 'Do you want to install homebrew software?'; then
    echo "Installing homebrew software ..."
    brew bundle
fi

# -------------------------------------------------------------------------------------------

# Install application settings
if ask_question 'Do you want to install application and MacOS settings?'; then
    echo "Installing application settings ..."
    for s in ./settings/*; do
        echo "Apply settings from $s ..."
        sh "$s"
    done
fi

# -------------------------------------------------------------------------------------------

# last action: activate dotfiles from repo, which depend of previously installed software (especially oh-my-zsh)
if ask_question 'Do you want to install .dotfiles?'; then
    echo "Installing .dotfiles with chezmoi ..."
    if [ $(which chezmoi) ]; then
        if [ -d "~/.local/share/chezmoi" ]; then
            cd ~
            cd ".local/share/chezmoi"
            git pull
            echo "chezmoi .dotfiles already installed, updated ..."
            cd ~
        else
            cd ~
            mkdir -p ".local/share/chezmoi"
            cd ".local/share/chezmoi"
            git clone https://github.com/jurgen-kluft/macos-dotfiles .
            chezmoi apply
            cd ~
        fi
    else
        echo "chezmoi dotfile manager is not installed (brew install chezmoi)"
    fi
fi

# -------------------------------------------------------------------------------------------

# Now ask for a reboot, which is highly recommended after installing and configuring everything
if ask_question 'Do you want to reboot your computer now?'; then
    echo "Rebooting ..."
    sudo reboot
    exit 0
fi

unset MACOS_SETUP_DIR
unset -f ask_question
exit 1
