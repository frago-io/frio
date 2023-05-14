{ config, pkgs, ... }:

let 
    tmuxRemoteConfFileName = "tmux.remote.conf";
    tmuxRemoteConf = pkgs.writeShellScriptBin tmuxRemoteConfFileName ''
          ${(builtins.readFile ./tmux.remote.conf)}
        '';
    in {
      enable = true;
      extraConfig = ''
          ${(builtins.readFile ./tmux.conf)}
          # Session is considered to be remote when we ssh into host
          if-shell 'test -n "$SSH_CLIENT"' \
              'source-file ${tmuxRemoteConf}/bin/${tmuxRemoteConfFileName}'
        '';
      plugins = 
         with pkgs; [
            {
              plugin = tmuxPlugins.cpu;
              extraConfig = ''
                %if '#{==:#{TMUX_SHOW_BATTERY},}'
                 VALUE='#[fg=colour237,bg=colour234] #{cpu_percentage} #{sysstat_mem} #[fg=colour233,bg=colour238,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
                 %else
                 VALUE='#[fg=colour237,bg=colour234] #{cpu_percentage} #{sysstat_mem} #[fg=colour233,bg=colour238,bold] %d/%m #{battery_color_charge_fg}#[bg=colour241,bold] #{battery_percentage} #[fg=colour233,bg=colour245,bold] %H:%M:%S '
                 %endif
                 set -g status-right $VALUE
                '';
            }{
              plugin = tmuxPlugins.better-mouse-mode;
              extraConfig = ''
                set-option -g mouse on
                '';
            }
            tmuxPlugins.battery
            tmuxPlugins.sysstat
            {
              plugin = tmuxPlugins.resurrect;
              extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            }
          ];
  }
