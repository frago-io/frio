# Yazi - terminal file manager (pinned to post-chafa-fix commit)
# This pins yazi from upstream flake to include the fix for:
#   "Chafa v1.18.1 causes random ghost keypresses when previewing images"
#   https://github.com/sxyazi/yazi/issues/3671
#   https://github.com/sxyazi/yazi/pull/3678
#
# TODO: Remove this once a stable yazi release includes the fix (> 26.1.22)
#       and switch back to pkgs.yazi from nixpkgs.
{ pkgs, ... }:
let
  system = builtins.currentSystem;
  yaziFlake = builtins.getFlake "github:sxyazi/yazi/c3bc4fecad9308846251ded5aad8509dd7a04158";
in
{
  packages = [
    yaziFlake.packages.${system}.default
    pkgs.chafa
  ];
}
