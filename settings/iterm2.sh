#!/usr/bin/env bash

#
# iTerm2 - copy settings
#

echo "Importing iTerm2 settings ..."

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/mac-os-setup/iterm2"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
