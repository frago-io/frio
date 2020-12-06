#!/bin/bash
source ./utils.sh
profile=$HOME/.nix-profile/bin
nix_zsh=$profile/zsh

if [[ $SHELL != $nix_zsh ]]; then 
    cmd="chsh -s $nix_zsh"
    shells=$(cat /etc/shells)

    if [[ $shells != *$nix_zsh* ]]; then 
        cmd="(echo \"$nix_zsh\" | sudo tee -a /etc/shells) && "$cmd
    fi

    zsh=zsh
    echoOK "frio installed.
    $ORANGE
    type $BLUE$nix_zsh$ORANGE when you want to enter in frio mode
    or
    you cand make zsh your default shell by typing following command:
    $BLUE$cmd
"


    else echoOK "frio installed"
fi

