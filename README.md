# dev-env
a development environment setup for projects within frago.io

prequisite for macos 
1. curl -L -o install-nix https://releases.nixos.org/nix/nix-2.3.16/install
 sh install-nix --darwin-use-unencrypted-nix-store-volume --daemon
2. nix-env -i home-manager

for all.

To install it copy/paste in your terminal the following command
```bash
bash <( curl -H 'Cache-Control: no-cache' -L -s https://raw.githubusercontent.com/frago-io/frio/main/bootstrap.sh )
```
or shorten
```bash
bash <( curl -H 'Cache-Control: no-cache' -L -s https://bit.ly/3mSQTQX )
```


1. install fzf-preview coc extension
```vim
:CocInstall coc-fzf-preview
```

