{ config, pkgs, lib, ... }:
{
  packages = [
    pkgs.ranger
    pkgs.glow
  ];

  files = {
    ".config/ranger/rc.conf" = {
      source = ./rc.conf;
      force = true;
    };
    ".config/ranger/rifle.conf" = {
      source = ./rifle.conf;
      force = true;
    };
    ".config/ranger/scope.sh" = {
      source = ./scope.sh;
      executable = true;
      force = true;
    };
    ".config/ranger/glow-ranger.json" = {
      source = ./glow-ranger.json;
      force = true;
    };
  };
}
