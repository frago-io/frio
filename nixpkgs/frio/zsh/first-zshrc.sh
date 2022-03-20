daemonNixSh=/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
if [ -e "$daemonNixSh" ];
    then source $daemonNixSh; 
fi

nixSh=/nix/var/nix/profiles/default/etc/profile.d/nix.sh
if [ -e "$nixSh" ]; 
then source $nixSh; 
fi

if [ -z "$NIX_PATH" ] && [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; 
    then . $HOME/.nix-profile/etc/profile.d/nix.sh; 
fi # added by Nix installer

