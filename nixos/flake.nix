{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "nextflake" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./installs/desktop-7950x.nix ];
      };
    };
  };
}
