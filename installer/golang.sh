#!/bin/bash
set -e

VERSION="1.11.12"

print_help() {
    echo "Usage: bash goinstall.sh OPTIONS"
    echo -e "\nOPTIONS:"
    echo -e "  --32\t\tInstall 32-bit version"
    echo -e "  --64\t\tInstall 64-bit version"
    echo -e "  --arm\t\tInstall armv6 version"
    echo -e "  --darwin\tInstall darwin version"
    echo -e "  --remove\tTo remove currently installed version"
}

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    # assume Zsh
    shell_profile="zshrc"
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # assume Bash
    shell_profile="bashrc"
fi

if [ "$1" == "--32" ]; then
    DFILE="go$VERSION.linux-386.tar.gz"
elif [ "$1" == "--64" ]; then
    DFILE="go$VERSION.linux-amd64.tar.gz"
elif [ "$1" == "--arm" ]; then
    DFILE="go$VERSION.linux-armv6l.tar.gz"
elif [ "$1" == "--darwin" ]; then
    DFILE="go$VERSION.darwin-amd64.tar.gz"
elif [ "$1" == "--remove" ]; then
    echo "Go should be removed manually!."
    exit 0
elif [ "$1" == "--help" ]; then
    print_help
    exit 0
elif [[ "$OSTYPE" == "darwin"* ]]; then
    DFILE="go$VERSION.darwin-amd64.tar.gz"
else
    print_help
    exit 1
fi

echo "Installing Go $VERSION from $DFILE"

if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ]; then
    echo "The 'go' or '.go' directories already exist. Exiting."
    exit 1
fi

echo "Downloading $DFILE ..."

wget https://dl.google.com/go/$DFILE -O /tmp/go.tar.gz

if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "Extracting $DFILE ..."
tar -C "$HOME" -xzf /tmp/go.tar.gz
mv "$HOME/go" "$HOME/.go"
mkdir -p $HOME/go/{src,pkg,bin}
echo -e "\nGo $VERSION was installed.\nMake sure to relogin into your shell or run:"
echo -e "\n\tsource $HOME/mac-os-dotfiles/.golang_paths.\n\nto update your environment variables."
echo "Tip: Opening a new terminal window usually just works. :)"
echo "Removing $DFILE ..."
rm -f /tmp/go.tar.gz
echo "Done ..."
