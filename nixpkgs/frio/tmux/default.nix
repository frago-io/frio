{ config, pkgs, ... }:

 let 
    in {
      enable = true;
      extraConfig = ''
          ${(builtins.readFile ./tmux.conf)}
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
            }
            tmuxPlugins.battery
            tmuxPlugins.sysstat
            {
              plugin = tmuxPlugins.resurrect;
              extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            }
          ];
  }
