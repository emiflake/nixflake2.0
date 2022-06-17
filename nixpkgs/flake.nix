{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
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
          system = "x86_64-linux";
          homeDirectory = "/home/emiflake";
          username = "emiflake";
          extraSpecialArgs = { inherit inputs system; };
          configuration.imports = [
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
          system = "aarch64-darwin";
          homeDirectory = "/Users/emiflake";
          username = "emiflake";
          extraSpecialArgs = { inherit inputs system; };
          configuration.imports = [
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

