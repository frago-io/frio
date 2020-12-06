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

  
  isDarwin = builtins.currentSystem == "x86_64-darwin";
  system = if isDarwin then "macOS" else "Linux";

  sha256 = if isDarwin
    then  "01yknxm17p0lm0ikkck9kdhlj9wbsdi0h7gzrxb8p8yqylsqja75"
    else "0q9zqa2pkczxh4h6jbqw60dajj38zjjc3c0jawnaqkfcyd9xjgjs";

  srcz = pkgs.fetchurl {
    url = "https://github.com/haskell/haskell-language-server/releases/download/0.6.0/haskell-language-server-"
      + system + "-0.6.0.tar.gz";
    sha256 = sha256;
  };
  sys = builtins.currentSystem;
  #srcx=./ghc865 + "/${sys}/hlsp.tar.gz";

in stdenv.mkDerivation rec {
    name = "haskel-lsp";
    #buildInputs = [ srcz ];
    src=./src;

    buildPhase = ''
      set -e
      echo "!!!!!!!!!!!!!!!!!!"

      echo "mkdir -p $out/bin"
      mkdir -p $out/bin

      echo "tar xf ${srcz} -C $out/bin"
      tar xf ${srcz} -C $out/bin

      echo "chmod -R +x $out/bin"
      chmod -R +x $out/bin
    '';

    installPhase = ''
      echo 'PULA=x'
    '';
  }

