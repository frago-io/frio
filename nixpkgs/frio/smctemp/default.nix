with import <nixpkgs> {};

let tmuxTemp = pkgs.fetchFromGitHub {
        owner = "kolach";
        repo="tmux-temp";
        rev="009bd2b0013a22285db0fd6764de6a29e53d1563";
        sha256="sha256-JO8L7BjriSAG1EdcJ+UUmZjlu5NkDwZYiiXtUmUR6xs=";
      };
in stdenv.mkDerivation rec {
    name = "smctemp";
    #buildInputs = [ srcz ];
    src=./src;

    buildPhase = ''
      set -e

      echo "mkdir -p $out/bin"
      mkdir -p $out/bin

      cp $src/smctemp $out/bin/smctemp

      echo "mkdir -p $out/share"
      ls -lah ${tmuxTemp}
      cp -r ${tmuxTemp}/ $out/share/
    '';

    installPhase = ''
      echo "installing"
      chmod +x $out/bin/smctemp
    '';
  }

