#!/bin/bash
source ./utils.sh

nixpkgs="$HOME/.config/nixpkgs"
homemanager="$HOME/.config/home-manager"
nixhere=$(pwd)/nixpkgs
nvim="$HOME/.config/nvim"

sameLink() {
    local l="$1"
    local f=$2
    local rl=$(readlink $l)
    #echo [[ $rl == $f]]
    if [[ $rl == $f ]]
        then echo 1
        else echo 0
    fi
}

mkdir -p $nixpkgs
mkdir -p $homemanager

testLink() {
    file=$1
    if [[ -e "$file" ]]
    then
        #echo "$file exists on your filesystem."
        smLink=$(sameLink $1 $2)
        #echo $smLink
        if [[ $smLink != 1 ]]; then
            echoError "$1 already exists but does not point to $2"
            exit 1
        fi
        echoOK "$1 already exists and points were it should ($2)"
    fi

    if [[ $? -ne 0 ]]; then
        echoError "some error occurred"
        exit 1
    fi
}

ensureLink() {
    file=$1
    if [[ ! -e "$file" ]]
    then
        # it could be a broken link: delete it
        rm -rf $1
        if [[ $? -ne 0 ]]; then
            echoError "\`rm -rf $1\` could not be executed"
            exit 1
        fi
        #echo "rm -rf $1"
        #echo "$file not exists on your filesystem."
        echo "ln -s $2 $1 "
        ln -s $2 $1
        echoOK "$1 linked to $2"
    fi
    if [[ $? -ne 0 ]]; then
        echoError "\`ln -s $2 $1\` could not be executed"
        exit 1
    fi
}

testLink $nixpkgs/frio $nixhere/frio
testLink $nixpkgs/home.nix $nixhere/home.frio.nix
testLink $homemanager/home.nix $nixhere/home.frio.nix
#testLink $nvim/coc-settings.json $nixhere/frio/neovim/coc-settings.json
#testLink $homemanager/flake.nix $nixhere/../flake.nix
#testLink $homemanager/flake.lock $nixhere/../flake.lock
#testLink $homemanager/_user.info.nix $nixhere/frio/_user.info.nix

ensureLink $nixpkgs/frio $nixhere/frio
ensureLink $nixpkgs/home.nix $nixhere/home.frio.nix
ensureLink $homemanager/home.nix $nixhere/home.frio.nix
#ensureLink $nvim/coc-settings.json $nixhere/frio/neovim/coc-settings.json
#testLink $homemanager/flake.nix $nixhere/../flake.nix
#testLink $homemanager/flake.lock $nixhere/../flake.lock
#testLink $homemanager/_user.info.nix $nixhere/frio/_user.info.nix

#cp -f $nixhere/../flake.nix $homemanager/flake.nix
#cp -f $nixhere/../flake.lock $homemanager/flake.lock
#cp -f $nixhere/frio/_user.info.nix $homemanager/_user.info.nix
