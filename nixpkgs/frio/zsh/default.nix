{ config, pkgs, ... }:

let 
    ls = import ./ls.nix;
    custom = import ./custom;
    in {
      enable = true;
      autocd = true;
      #enableAutosuggestions = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      zplug = {
        enable = false; 
        plugins = [
          { name = "nix-community/nix-zsh-completions"; } 
        ];
      };
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
          alias lsa="ls -lh --group-directories-first"
          alias l="la"
        '';
      initExtraFirst = ''
          ${(builtins.readFile ./first-zshrc.sh)}
        '';

        oh-my-zsh = {
        custom="${custom}";
        enable = true;
        #theme = "gianu";
        #theme = "mh";
        #theme = "refined";
        theme = "my-refined";
        plugins=
          [ "git"
          "tmux"
          "docker"
          "vi-mode"
          "systemd"
          "z"
          "web-search"
        ];
      };
  }
