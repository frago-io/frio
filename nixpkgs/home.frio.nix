{ config, pkgs, ... }:
let 
  common = {
    inherit config pkgs;
  };
  neovim = import ./frio/neovim common;
  zsh = import ./frio/zsh common;
  tmux = import ./frio/tmux common;
  userInfo = import ./frio/_user.info.nix;
  hlsp= import ./frio/haskell/lsp/default.nix;

  python-packages = pyPacks: with pyPacks; [
    #pandas
    #requests
    # other python packages you want
  ]; 
  python-with-packages = pkgs.python3.withPackages python-packages;
  isDarwin = builtins.currentSystem == "x86_64-darwin";

in  {
  home.packages = (
    if !isDarwin then [
      pkgs.nmon

      #building
      pkgs.glibcLocales
      #pkgs.gmp4
      #pkgs.binutils
      #pkgs.glibc
    ] else []
    ) ++ [
    hlsp
    #python-with-packages

    # UNIX UTILS  ***************************************************
    pkgs.git
    pkgs.jq                                  # json command processor
    pkgs.perl
    pkgs.asciinema
    pkgs.tmate

    # core-*nix
    #pkgs.coreutils-full
    #pkgs.gnumake
    #pkgs.xz
    #pkgs.gnutar
    #pkgs.gnused
    #pkgs.gnugrep
    #pkgs.less
    #pkgs.gcc
    #pkgs.findutils
    #pkgs.gawk
    #pkgs.dash
    #pkgs.glibc
    #pkgs.glibc-2.32

    # JAVASCRIPT ****************************************************
    #pkgs.nodejs
    #pkgs.yarn

    # LANG UTILS ****************************************************
    pkgs.ctags

    # MONITOR / ADMIN  **********************************************
    pkgs.htop

    # FUN  **********************************************************
    pkgs.fortune
    pkgs.cowsay
    pkgs.lolcat
    
    # HASKELL *******************************************************
    #pkgs.cabal-install
    #pkgs.haskell.compiler.ghc865
    #pkgs.stack
    #pkgs.haskell.packages.ghc865.haskell-language-server
    #pkgs.haskell.packages.ghc8101.haskell-language-server
    #pkgs.haskellPackages.haskell-language-server
    pkgs.haskellPackages.hasktags
    pkgs.haskellPackages.stack
    pkgs.haskellPackages.hoogle
    pkgs.stylish-haskell

  ];

  programs.bat = {
    enable = true;
    config = {
      theme="1337";
      style="numbers,changes,header";
      italic-text="always";
      map-syntax="*.ino:C++";
    };
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [
       "--color=fg:#cbccc6,bg:#1f2430,hl:#707a8c"
       "--color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66"
       "--color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6"
       "--color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff"
    ];
  };


  programs.neovim = neovim;
  programs.zsh = zsh;
  programs.tmux = tmux;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  #home.username = "apophis";
  #home.homeDirectory = "/home/apophis";
  home.username = userInfo.username;
  home.homeDirectory = userInfo.homeDirectory;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
