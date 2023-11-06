{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
  common = {
    inherit config pkgs;
  };
  frioHome = import ./nixpkgs/home.frio.nix common;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.horus = frioHome;

  #home-manager.users.horus = {
  #  /* The home.stateVersion option does not have a default and must be set */
  #  home.stateVersion = "21.03";
  #  /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  #};
}
