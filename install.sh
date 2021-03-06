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

source ./change-shell.sh
