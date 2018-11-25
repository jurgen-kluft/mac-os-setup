mkdir tmpvscode
cd tmpvscode
curl --remote-name-all -L https://go.microsoft.com/fwlink/\?LinkID\=620882 -o vscode-darwin.zip
unzip -o vscode-darwin.zip
mv "Visual Studio Code.app" "/Applications/Visual Studio Code.app"
cd ..
rm -rdf tmpvscode

