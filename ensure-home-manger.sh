#!/bin/bash
#nix-channel --remove home-manager
source ./utils.sh
LOL=$(nix-channel --list)

if ! command -v nix-channelss &> /dev/null
then
    echoError "nix is not installed"
    exit 1
fi


if [[ $LOL == *home-manager\ * ]] 
  then
      echoB "home-manager channel already there"
      exit 0
  else 
      echoP "adding home-manager channel"
      nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
      nix-channel --update
      echoOK "home-manager channel added"
      echoP "installing home-manager"
      nix-shell '<home-manager>' -A install
      echoOK "home-manager installed"
fi

