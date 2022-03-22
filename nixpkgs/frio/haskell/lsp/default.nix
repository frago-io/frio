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

  
  isDarwin = builtins.currentSystem == "x86_64-darwin" ||  builtins.currentSystem == "aarch64-darwin";
  system = if isDarwin then "macOS" else "Linux";
  isM1 = builtins.currentSystem == "aarch64-darwin";

  srcz_060 = pkgs.fetchurl {
    url = "https://github.com/haskell/haskell-language-server/releases/download/0.6.0/haskell-language-server-"
       + system + "-0.6.0.tar.gz";
    sha256 = if isDarwin
      then  "01yknxm17p0lm0ikkck9kdhlj9wbsdi0h7gzrxb8p8yqylsqja75"
      else "0q9zqa2pkczxh4h6jbqw60dajj38zjjc3c0jawnaqkfcyd9xjgjs";
    };

  srcz_071 = pkgs.fetchurl {
    url = "https://github.com/haskell/haskell-language-server/releases/download/0.7.1/haskell-language-server-"
      + system + "-0.7.1.tar.gz";
    sha256 = if isDarwin
      then  "1v947741qhg13sqvfwmdvrr1kzk6cbkyd7kri8s4zfsaqz7kgb47"
      else "0qkzc88i3n2iyaj9xjdpx7iykz2aqffkc7s1ka2s24qnz78knkz7";
    };
  srcz_1610 = pkgs.fetchurl {
    url = if isM1 
      then "https://github.com/haskell/haskell-language-server/releases/download/1.6.1.0/haskell-language-server-macOS-aarch64-1.6.1.0.tar.xz"
      else "https://github.com/haskell/haskell-language-server/releases/download/1.6.1.0/haskell-language-server-"
        + system + "-1.6.1.0.tar.gz";
        sha256 = if isM1 then "sha256-/sojNte5jSPO/xBDjSZHbHHObOReYXGVknVWok4UgL8="
                 else if isDarwin then  "sha256-KHrfF6TVcEMWpd1EFxmm9q1lerasZgoXv8oMB8KDprg="
                 else "sha256-A/EyFCFsOcCe2dBzMXy/e9yYp10MTuL9Um5EZFdZHSU=";
    };

  srcz = srcz_1610;
  sys = builtins.currentSystem;
  #srcx=./ghc865 + "/${sys}/hlsp.tar.gz";

in stdenv.mkDerivation rec {
    name = "haskel-lsp";
    #buildInputs = [ srcz ];
    src=./src;

    buildPhase = ''
      set -e

      echo "mkdir -p $out/bin"
      mkdir -p $out/bin

      echo "tar xf ${srcz} -C $out/bin"
      tar xf ${srcz} -C $out/bin

    '';

    installPhase = ''
      echo "chmod -R +x $out/bin"
      chmod -R +x $out/bin
    '';
  }

