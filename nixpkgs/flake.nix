{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    homeConfigurations = {
      fidelity = inputs.home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/emiflake";
        username = "emiflake";
        configuration.imports = [
          ./modules/home-manager.nix
          ./modules/common.nix
          ./modules/zsh.nix
          ./modules/neovim.nix
        ];
      };
    };
  };
}

