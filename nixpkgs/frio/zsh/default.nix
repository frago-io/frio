{ config, pkgs, ... }:

let 
    ls = import ./ls.nix;
    in {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;
      initExtra = ''
          ${(builtins.readFile ./utils.sh)}
          ${(builtins.readFile ./zshrc)}

          # Set LS_COLORS
          eval $(${ls}/bin/dircolors ${./LS_COLORS})

          #for some reason ls is aliased to ls -G
          # so we need to unalias it
          #unalias ls
          alias ls="${ls}/bin/ls --color=auto -F"
          alias la="ls -lAh --group-directories-first"
        '';
      initExtraFirst = ''
          ${(builtins.readFile ./first-zshrc.sh)}
        '';

      oh-my-zsh = {
        enable = true;
        theme = "gianu";
        plugins=["git" "tmux" "docker" "vi-mode" "systemd" "z" ];
      };
  }
