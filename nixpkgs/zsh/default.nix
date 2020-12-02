{ config, pkgs, ... }:

 let 
    in {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;
      initExtra = ''
          ${(builtins.readFile ./zshrc)}
        '';

      oh-my-zsh = {
        enable = true;
        theme = "gianu";
        plugins=["git" "tmux" "docker" "vi-mode" "systemd" "z" ];
      };
  }
