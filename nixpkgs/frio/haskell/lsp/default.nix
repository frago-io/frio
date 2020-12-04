with import <nixpkgs> {};

let
  # The ${...} is for string interpolation
  # The '' quotes are used for multi-line strings
  #simplePackage = pkgs.writeShellScriptBin "whatIsMyIp" ''
    #${pkgs.curl}/bin/curl http://httpbin.org/get \
      #| ${pkgs.jq}/bin/jq --raw-output .origin
  #'';
  #srcx = pkgs.fetchgit {
    #url = "https://github.com/haskell/haskell-language-server.git";
    #rev = "f8fdf2a9c1e813d5db9193b9eba15a591a57fd02";
    #sha256 = "1082zhkja71klk1pcfn44zkrv6dg0rlni3abllgp6r7sbwddicna";
  #};

  sys = builtins.currentSystem;
  srcx=./ghc865 + "/${sys}/hlsp.tar.gz";

in stdenv.mkDerivation rec {
    name = "haskel-lsp";
    src=srcx;
    #buildInputs = [ ];
    buildPhase = ''
      set -e

      echo "mkdir -p $out/bin"
      mkdir -p $out/bin

      echo "tar xf ${srcx} -C $out"
      tar xf ${srcx} -C $out
    '';

    installPhase = ''
      echo 'PULA=x'
    '';
  }

