#!/bin/bash
user=$(whoami)
#home.username = "apophis";
#home.homeDirectory = "/home/apophis";
source ./utils.sh
file=nixpkgs/frio/_user.info.nix
echo "{ 
    username=\"$user\";
    homeDirectory=\"$HOME\";
}" > $file 

if [[ $? -ne 0 ]]; then
    echoError "$file could not be written written"
    exit 1
fi
echoOK "$file written"
