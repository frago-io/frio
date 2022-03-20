# dev-env
a development environment setup for projects within frago.io

## prequisite for macos
The issue for newer nix versions is that adding homamanger channel is not working to build anymore home-manger
because of the channel. trye to exclude the channel from install. otherwise let's do this for the momen
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon

IMPORTANT: restart shell

# Install Home Manager
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\n 

nix-shell '<home-manager>' -A install
```

IMPORTANT: restart shell

```bash
echo 'export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\n' >> ~/.bash_profile
echo 'export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\n' >> ~/.zshenv
```


for all.

## To install it copy/paste in your terminal the following command
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

