{ config, pkgs, ... }:

let 
    tmuxRemoteConfFileName = "tmux.remote.conf";
    tmuxRemoteConf = pkgs.writeShellScriptBin tmuxRemoteConfFileName ''
          ${(builtins.readFile ./tmux.remote.conf)}
        '';
    tmuxTemp = pkgs.fetchFromGitHub {
        owner = "kolach";
        repo="tmux-temp";
        rev="009bd2b0013a22285db0fd6764de6a29e53d1563";
        sha256="sha256-JO8L7BjriSAG1EdcJ+UUmZjlu5NkDwZYiiXtUmUR6xs=";
      };
    in {
      enable = true;
      extraConfig = ''
          ${(builtins.readFile ./tmux.conf)}
          run-shell ${tmuxTemp}/temp.tmux
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
                 VALUE='#[fg=colour237,bg=colour234] #{cpu_percentage} #{sysstat_mem} #[fg=colour233,bg=colour238,bold]#{temp_cpu} #{battery_color_charge_fg}#[bg=colour241,bold] ⌁ #{battery_percentage} #[fg=colour233,bg=colour245,bold] %H:%M:%S '
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
