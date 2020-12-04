#!/bin/bash

source ./utils.sh
source ./ensure-links.sh
source ./ensure-user-info.sh
source ./ensure-home-manger.sh

echoP "updating frio"
home-manager switch
if [[ $? -ne 0 ]]; then
    echoError "frio could not be updated"
    exit 1
fi

if [[ $SHELL != $(which zsh) ]];
    then echoOK "frio installed.

    type \`zsh\` when you want to enter in frio mode
    or
    you cand make zsh your default shell by typing: \`chsh -s $(which zsh)\`"

    else echoOK "frio installed"
fi
