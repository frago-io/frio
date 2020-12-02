#!/bin/bash
LOL=$(nix-channel --list)

if [[ $LOL == *home-manager\ * ]] 
  then
  echo yes
fi
echo $LOL
