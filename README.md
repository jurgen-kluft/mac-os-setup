# MacOS developer setup - dotfiles and software

This is a not only a simple .dotfiles repo from a developer but also a bunch of scripts to create a full featured working environment for myself.

Be careful: it was never meant to run with any other OS, so don't try it!

## What is included?

Its a backup and "out-of-the-box setup" for my working environment. Well, at least for everything that is possible to be setup in an automated way.

That repo was mainly written to share my learnings and quickly become productive on a new machine. I also hope that you will use it as an inspiration for your own environment.
Its fun for me to play around with this setup and improve my tooling and workflow, so this repo might get changed quite often.

Main files and folder:

- `mac-os-setup/`
  - `bin/` - helper scripts and binaries  
  - `helpers/` - helper scripts during install
  - `installer/` - some basic software installer, that can't be fetched by Homebrew
  - `iterm2/` - my iTerm2 configuration, files will be linked via MacOS configuration (manual restart iTerm2 afterwards)
  - `settings/` - installer scripts for settings
  - `Brewfile` - all the brew repos that will be watched and the software to be installed  

- `github.com/your-name/mac-os-dotfiles/` - should be cloned into ~/.local/share/chezmoi

After you have cloned the repository there and have installed chezmoi with brew (brew install chezmoi) you can run the command `chezmoi apply`.

## Adjust to your needs

Make sure that you checked the following points before you run the installer:

- Remove any file from `installer/` that you don't need
- Carefully read and adjust `Brewfile` to only install the software you need
- Make sure that `settings/.macos` settings are thoroughly reviewed
- Adjust your Git credentials and GitHub settings in `settings/git.sh`
- add the file `~/mac-os-setup/.local` or `~/.bash_local` for all your sensitive local settings

## Installation

You will be prompted during each installation step for your permission.
But a word of warning nevertheless: create a backup of your dotfiles and/or your environment first!

```bash
git clone https://github.com/jurgen-kluft/mac-os-setup.git
```

If you don't want to install to `~/mac-os-setup/` you MUST search for that string and replace it in some files!

Installation (as well as updating later on) is as simple as calling `install.sh`:

```bash
cd ~/mac-os-setup/
./install.sh
```

If oh-my-zsh interupts the installation by changing the shell, simply enter `exit` and you will get back
to the installation flow. After the istallation is finished, restart your terminal/iTerm2.

## Roadmap

This repo is missing a lot of cool things, so my roadmap has at least the following stuff on it:

- Support for [custom](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization) zsh configs and plugins at `zsh/*.zsh`
- [Powerlevel9k](https://gist.github.com/kevin-smets/8568070)
- Keep PHPStorm setting in repo
- [Solarized color scheme for PHPStorm](https://github.com/altercation/solarized/tree/master/intellij-colors-solarized)
- Test and add `oh-my-zsh` plugins: colored-man colorize github jira vagrant virtualenv osx zsh-syntax-highlighting fabric node npm history git-flow

## Applications that need to be installed manually

- [Etcher](https://etcher.io/) (burn SD images)
- Monosnap (App Store)
- XCode (App Store)
- Spark

## Inspired by ❤

- [Oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh) feel nerdy in your terminal
- [Nick Plekhanov's Dotfiles](https://github.com/nicksp/dotfiles) and his zsh inspiration
- [Dotfiles](http://dotfiles.github.io/) the unofficial guide to dotfiles on GitHub
- [Kevin Elliott](https://github.com/kevinelliott/.dotfiles) for his dotfiles repo
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) for all his scripts
- Read through the source files, there are more mentions included ...
