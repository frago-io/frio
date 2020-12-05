#!/bin/bash
#nix-channel --remove home-manager

source ./utils.sh
LOL=$(nix-channel --list)
NIX_CHN=nix-channel
if ! command -v $NIX_CHN &> /dev/null
then

    echo ""
    echoB "${BOLD}No nix installation found on your user"
    echo -e "${BLUE}
What do you plan to do?

    1. We install Nix for you and yourself only (single-user mode)

    2. Install it yourself in multi-user mode

    3. We forget about you, you forget about us, life goes on 

NOTE: If you choose single-user mode, no other users can use/install 
      Nix in your system until a multi-user switch is made
${RESET}"

    msg="Choose your destiny [1/2/3] (default 1): 🥋 "
    read -p "$(echo -e $ORANGE$msg$RESET)" ans
    echo ""

    if [ -z "$ans" ] || [[ $ans == 1 ]] ; then
          curl -L https://nixos.org/nix/install | sh
          if [[ $? -ne 0 ]]; then
              echoError "nix-os installation failed"
              exit 1
          fi
          echoB "executing '. $HOME/.nix-profile/etc/profile.d/nix.sh"
          $(. $HOME/.nix-profile/etc/profile.d/nix.sh)
          if ! command -v $NIX_CHN &> /dev/null; then
              echo ""
              echoError "ASDADASDASD can't find nix-channel command. Please see details above to grasp what might have got wrong"
              echo ""
              exit 1
          fi
        exit
    elif [[ $ans == 2 ]]; then
        echoB "Oh, we have a PRO 👋

   visit https://nixos.wiki/wiki/Install_Nix_in_multi-user_mode_on_non-NixOS for more information
"
        exit
    elif [[ $ans == 3 ]]; then
        echoG "Actually we will never ever forget you 👋"
        echo ""
        exit
    else 
        echoError "'$ans' is not a valid answer see you next time, 👋 bye bye now"
        exit
    fi
fi


if [[ $LOL == *home-manager\ * ]] 
  then
      echoB "home-manager channel already there"
  else 
      echoP "adding home-manager channel"
      nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
      if [[ $? -ne 0 ]]; then
          echoError "manager-channel could not be added"
          exit 1
      fi
      nix-channel --update
      if [[ $? -ne 0 ]]; then
          echoError "nix-channel could not be updated"
          exit 1
      fi
      echoOK "home-manager channel has been added"
fi
if ! command -v home-manager &> /dev/null
then
      echoP "installing home-manager"
      nix-shell '<home-manager>' -A install
      if [[ $? -ne 0 ]]; then
          echoError "home-manager could not be installed"
          exit 1
      fi
      echoOK "home-manager has been installed"
else
      echoB "home-manager itself is already installed"
fi

