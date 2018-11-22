#!/usr/bin/env bash

#
#  My sources for OSX settings:
#
# https://github.com/skwp/dotfiles/blob/master/bin/osx
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# https://github.com/hjuutilainen/dotfiles/tree/master/bin
# http://mths.be/osx
# https://github.com/kaicataldo/dotfiles
#

echo "Applying MacOS settings ..."

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront (seems not to be required)
#sudo -v

# Keep-alive: update existing `sudo` time stamp until everything is applied
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name
#COMPUTERNAME="obnosis1"
#HOSTNAME='imac'
#LOCALHOSTNAME='imac'

# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName $COMPUTERNAME
#sudo scutil --set HostName $HOSTNAME
#sudo scutil --set LocalHostName $LOCALHOSTNAME
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $LOCALHOSTNAME

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
#defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Doesn't work with High Sierra any longer...
# Disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# make sure everything uses these new settings                                #
###############################################################################

killall Finder
# killall SystemUIServer
