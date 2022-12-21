{ config, pkgs, libs, ... }:
{
  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.enableFishIntegration = false;

  home.packages = with pkgs; [
    wget
    du-dust
    bash
    docker
    coreutils
    ripgrep
    nix
    github-cli
    file
    cachix
  ];

  home.file = {
    ".ghci".text = ''
      :set prompt "λ> "
      :set +s
    '';

    ".haskeline".text = ''
      editMode: Vi
    '';
  };

  programs.jq.enable = true;
  programs.htop.enable = true;
}
