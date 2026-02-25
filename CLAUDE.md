# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Frio** is a reproducible development environment configuration tool built on Nix and Home Manager. It provides a declarative, version-controlled setup for development tools, shell configuration, editor plugins, and system utilities that works across macOS and Linux.

The main use case: users run a bootstrap script that installs/configures their entire development environment in one command.

## Building, Installing, and Development Commands

### Installation
```bash
# Remote installation (from any machine)
bash <(curl -H 'Cache-Control: no-cache' -L -s https://raw.githubusercontent.com/frago-io/frio/main/bootstrap.sh)

# Or from local repo after cloning
bash ./install.sh
```

### Applying Configuration Changes
```bash
# Apply changes made to .nix files
home-manager switch

# Alias shortcut
hh  # (defined in zsh config)
```

### Updating the Environment
```bash
# From zsh shell - re-runs latest bootstrap and apply
frio update
```

### Key Installation Scripts
- `bootstrap.sh` - Remote entry point; downloads tarball and runs install
- `install.sh` - Orchestrates setup: symlinks configs, ensures Nix/Home Manager, applies configuration
- `ensure-links.sh` - Creates symlinks for config files
- `ensure-user-info.sh` - Generates user metadata (username, home directory)
- `ensure-home-manger.sh` - Detects/installs Nix, adds home-manager channel
- `utils.sh` - Shared shell functions for colored output

## Architecture and Key Components

### Component Structure
```
frio/
├── flake.nix                          # Nix flakes manifest (nixpkgs-24.11, home-manager-24.11)
├── nixpkgs/home.frio.nix              # Main Home Manager configuration (~182 lines)
└── nixpkgs/frio/                      # Component modules
    ├── neovim/                        # Neovim with 40+ plugins, LSP, Treesitter
    │   ├── default.nix                # Main neovim configuration (~680 lines)
    │   ├── init.lua                   # Lua initialization
    │   ├── cmp-nvim-lsp.lua           # Completion setup
    │   ├── nvim-treesitter.lua        # Syntax highlighting
    │   └── (other .lua plugin configs)
    ├── zsh/                           # Zsh shell with oh-my-zsh
    ├── tmux/                          # Tmux multiplexer with plugins
    ├── python.nix                     # Python 3 environment
    └── _user.info.nix                 # User metadata (generated at install)
```

### Configuration Flow
1. `flake.nix` declares Nixpkgs and Home Manager dependencies
2. `home.frio.nix` imports all components (neovim, zsh, tmux, packages)
3. Components are modular and independently configured in `nixpkgs/frio/`
4. `home-manager switch` applies all changes atomically
5. Shell defaults, symlinks, and user info are set up by install scripts

### Key Design Patterns
- **Modular Nix**: Components are separate files imported into main config
- **Platform Detection**: Conditional packages for macOS (smctemp, neovide) vs Linux
- **LSP Configuration**: Per-language server setup (Haskell, TypeScript, YAML, Nix)
- **Plugin Management**: Neovim plugins declared in Nix, built with `pkgs.vimUtils.buildVimPlugin`
- **Locked Dependencies**: `flake.lock` ensures reproducible installations across machines

## Important Development Notes

### Neovim Configuration
- Heavily configured with 40+ plugins
- LSP setup in `cmp-nvim-lsp.lua` - handles language servers and completion
- Treesitter syntax highlighting in `nvim-treesitter.lua`
- Custom Haskell LSP project config can be overridden in `~/.vim/haskell-lsp.lua`
- Includes AI integration (Avante plugin for Claude Code)
- Git integration: vim-fugitive, vim-gitgutter, custom GitLab support

### Shell (Zsh)
- Uses oh-my-zsh framework
- Custom theme: `my-refined`
- FZF integration for fuzzy search
- Direnv for project-specific environments
- Common alias: `hh` for `home-manager switch`

### Tmux
- CPU, battery, and system stats monitoring
- Remote SSH detection for different display modes
- Persistent plugins via tpm

### Special Notes
- **Haskell Language Server**: Disabled in packages; users must install from ghcup: `ghcup install hls-1.7.0.0`
- **Node.js**: Disabled in packages; users should use NVM
- **Python**: Framework available but some packages may be disabled
- **macOS**: Requires `--darwin-use-unencrypted-nix-store-volume` flag during Nix install (see README)

## Common Tasks

### Adding a New Package
1. Edit `nixpkgs/home.frio.nix`
2. Add to `home.packages` list
3. Run `home-manager switch` to apply

### Adding a Neovim Plugin
1. Edit `nixpkgs/frio/neovim/default.nix`
2. Add plugin to `plugins` list using `pkgs.vimUtils.buildVimPlugin` or `pkgs.vimPlugins.*`
3. Add plugin configuration in appropriate `.lua` file or inline
4. Run `home-manager switch`

### Modifying Zsh or Tmux Config
1. Edit files in `nixpkgs/frio/zsh/` or `nixpkgs/frio/tmux/`
2. Run `home-manager switch`
3. Reload shell: `exec zsh` or tmux source-file

### Debugging Configuration Issues
- Check `home-manager switch` output for errors
- Look at `.nix` files for syntax issues (Nix is strict)
- For Neovim issues: check Lua files for syntax errors
- Use `nix flake show` to see available configurations

## Dependencies and Tools

### Core Dependencies
- **Nixpkgs**: `nixos-24.11` channel
- **Home Manager**: `release-24.11` channel
- **Nix**: Single-user or multi-user installation (detected/installed automatically)

### Major Tools Included
- **Editor**: Neovim with LSP (Haskell, TypeScript, YAML, Nix, Solidity)
- **Shell**: Zsh + oh-my-zsh + FZF + Direnv
- **Terminal**: Tmux with monitoring
- **VCS**: Git, Git LFS
- **Languages**: Rust (rustup), Haskell (cabal, stack, ghc)
- **Search**: Ripgrep, FZF, Telescope, Silver Searcher
- **Monitoring**: Htop, Btop, Neofetch, LM Sensors (Linux), SMCTemp (macOS)
- **Utilities**: JQ, Perl, Curl, Wget, GPG, Pinentry

## File Organization

When modifying files:
- **Nix files** (`.nix`): Configuration declarations in standard Nix language
- **Lua files** (`.lua`): Neovim plugin configuration (Lua language)
- **Shell scripts** (`.sh`): Installation and setup scripts with bash/sh
- **Lock file** (`flake.lock`): Auto-generated; don't edit manually

## When Making Changes

- Configuration is declarative; test with `home-manager switch`
- All changes should be version-controlled (commit to git)
- Nix files are strictly typed; small syntax errors cause full build failures
- Platform-specific code: use `isDarwin = builtins.elem builtins.currentSystem [ "x86_64-darwin" "aarch64-darwin" ]`
- When adding external packages: pin versions in `flake.lock` for reproducibility
- **Keymap changes**: Whenever a keymap is added, removed, or modified in any Neovim config file (init.lua, default.nix plugin configs, 99.lua, telescope-config.lua, lsp.lua, etc.), you MUST also update the static keymap reference in `nixpkgs/frio/neovim/maps.lua` (used by the `:StaticMaps` command) to keep it in sync. The dynamic `:Maps` command auto-discovers keymaps at runtime, but `:StaticMaps` is a hand-curated reference that needs manual updates.
