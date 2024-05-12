#!/bin/bash
set -e

VERSION="1.22.3"

print_help() {
    echo "Usage: bash goinstall.sh OPTIONS"
    echo -e "\nOPTIONS:"
    echo -e "  --32\t\tInstall 32-bit version"
    echo -e "  --64\t\tInstall 64-bit version"
    echo -e "  --arm\t\tInstall armv6 version"
    echo -e "  --darwin\tInstall darwin version"
    echo -e "  --remove\tTo remove currently installed version"
}

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


if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ]; then
    echo "Go is already installed, 'go' or '.go' directories exist."
    exit 1
fi

echo "Installing Go $VERSION from $DFILE"

echo "Downloading $DFILE ..."

wget https://golang.google.cn/dl/$DFILE -O /tmp/go.tar.gz

if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "Extracting $DFILE ..."
tar -C "$HOME" -xzf /tmp/go.tar.gz
mkdir -p "$HOME/dev.go/src"
mkdir -p "$HOME/dev.go/bin"
mkdir -p "$HOME/dev.go/pkg"
mkdir -p "$HOME/go/src"
mkdir -p "$HOME/go/pkg"
mkdir -p "$HOME/go/bin"
echo -e "\nGo $VERSION was installed.\nMake sure to relogin into your shell or run:"
echo -e "\n\tsource $HOME/mac-os-dotfiles/.golang_paths.\n\nto update your environment variables."
echo "Tip: Opening a new terminal window usually just works. :)"
echo "Removing $DFILE ..."
rm -f /tmp/go.tar.gz

mv "$HOME/go" "$HOME/sdk/go$VERSION"

if [ -d "$HOME/sdk/go" ]; then
    rm $HOME/sdk/go
fi
ln -s $HOME/sdk/go$VERSION $HOME/sdk/go

go env -w GOSUMDB=sum.golang.google.cn
go env -w GOPROXY=https://goproxy.cn

echo "Done ..."
