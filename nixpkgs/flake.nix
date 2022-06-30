{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
    nixpkgs-21_11.url = "github:NixOS/nixpkgs/21.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    rnix-lsp.url = "github:nix-community/rnix-lsp";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs";
    doom-emacs.url = "github:hlissner/doom-emacs/develop";
    doom-emacs.flake = false;
  };

  outputs = inputs:
    {
      homeConfigurations = {
        nixflake = inputs.home-manager.lib.homeManagerConfiguration rec {
          pkgs = import inputs.nixpkgs { localSystem = "x86_64-linux"; };
          extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
          modules = [
            {
              home = {
                homeDirectory = "/home/emiflake";
                username = "emiflake";
                stateVersion = "22.11";
              };
            }
            ./modules/home-manager.nix
            ./modules/common.nix
            ./modules/zsh.nix
            ./modules/neovim.nix
            ./modules/git.nix
            ./modules/kitty.nix
            ./modules/de.nix
            ./modules/desktop-apps.nix
            ./modules/nixpkgs.nix
            ./modules/user-theme
            ./modules/emacs.nix
          ];
        };
        fidelity = inputs.home-manager.lib.homeManagerConfiguration rec {
          pkgs = import inputs.nixpkgs { localSystem = "aarch64-darwin"; };
          extraSpecialArgs = { inherit inputs; system = "aarch64-darwin"; };
          modules = [
            {
              home = {
                homeDirectory = "/Users/emiflake";
                username = "emiflake";
                stateVersion = "22.11";
              };
            }
            inputs.nix-doom-emacs.hmModule
            ./modules/home-manager.nix
            ./modules/common.nix
            ./modules/zsh.nix
            ./modules/neovim.nix
            ./modules/emacs.nix
          ];
        };
      };
    };
}

