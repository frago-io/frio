with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "frio-custom-zsh";
    src=./files;

    buildPhase = ''
      set -e

      echo "cp -r . $out"
      cp -r . $out
    '';
  }
