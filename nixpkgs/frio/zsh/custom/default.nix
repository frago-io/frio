with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "frio-custom-zsh";
    src=./files;

    buildPhase = ''
      set -e

      echo "cp -r . $out"
    '';
    installPhase = ''
      cp -r . $out
    '';
  }
