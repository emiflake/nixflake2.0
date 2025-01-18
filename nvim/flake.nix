{
  description = "nvim config";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        devShell = pkgs.mkShell {
          name = "dev shell";
          buildInputs =
            [ pkgs.lua-language-server pkgs.stylua pkgs.luajit pkgs.git ];
        };
      });
}
