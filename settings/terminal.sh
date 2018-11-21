#!/bin/bash

# Updating to custom obnosis terminal theme
open "Obnosis.terminal"

sleep 1 # Wait a bit to make sure the theme is loaded

defaults write com.apple.terminal "Default Window Settings" "Obnosis"
defaults write com.apple.terminal "Startup Window Settings" "Obnosis"