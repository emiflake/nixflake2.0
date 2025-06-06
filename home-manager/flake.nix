{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
    nixpkgs-21_11.url = "github:NixOS/nixpkgs/21.11";
    nixpkgs-pin1.url =
      "github:NixOS/nixpkgs?rev=c2e7745b08a303b468fcaced4bf0774900aba9bc";
    nixpkgs-plover.url = "github:evils/nixpkgs/plover";
    # plover-flake.url = "/home/emi/dev/indev/plover-flake";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    rnix-lsp.url = "github:nix-community/rnix-lsp";
    # nix-doom-emacs.url = "github:vlaci/nix-doom-emacs";
    # doom-emacs.url = "github:hlissner/doom-emacs/develop";
    # doom-emacs.flake = false;
  };

  outputs = inputs: {
    devShells = let
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forEachSystem = f:
        builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        }) systems);
    in forEachSystem (system:
      let pkgs = import inputs.nixpkgs { inherit system; };
      in {
        default = pkgs.mkShell { buildInputs = with pkgs; [ nixpkgs-fmt ]; };
      });
    homeConfigurations = {
      nextflake = inputs.home-manager.lib.homeManagerConfiguration rec {
        pkgs = import inputs.nixpkgs { localSystem = "x86_64-linux"; };
        extraSpecialArgs = {
          inherit inputs;
          system = "x86_64-linux";
        };
        modules = [
          {
            home = {
              homeDirectory = "/home/emi";
              username = "emi";
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
          ./modules/user-theme.nix
        ];
      };

      # Legacy system. No longer used
      nixflake = inputs.home-manager.lib.homeManagerConfiguration rec {
        pkgs = import inputs.nixpkgs { localSystem = "x86_64-linux"; };
        extraSpecialArgs = {
          inherit inputs;
          system = "x86_64-linux";
        };
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
          ./modules/user-theme.nix
          ./modules/emacs.nix
        ];
      };
      bbu = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs { localSystem = "x86_64-linux"; };
        extraSpecialArgs = {
          inherit inputs;
          system = "x86_64-linux";
        };
        modules = [
          {
            home = {
              homeDirectory = "/home/emi";
              username = "emi";
              stateVersion = "22.11";
            };
          }
          ./modules/home-manager.nix
          ./modules/common.nix
          ./modules/zsh.nix
          ./modules/neovim.nix
          ./modules/git.nix
          ./modules/nixpkgs.nix
          ./modules/user-theme.nix
        ];
      };
      fidelity = inputs.home-manager.lib.homeManagerConfiguration rec {
        pkgs = import inputs.nixpkgs { localSystem = "aarch64-darwin"; };
        extraSpecialArgs = {
          inherit inputs;
          system = "aarch64-darwin";
        };
        modules = [
          {
            home = {
              homeDirectory = "/Users/emi";
              username = "emi";
              stateVersion = "22.11";
            };
          }
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

