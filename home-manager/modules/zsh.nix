{ config, pkgs, libs, ... }:
{

  home.packages = with pkgs; [
    bat
  ];
  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "23377e74c3780a1d4807a821df4011d3c793e69c";
          sha256 = "sha256-zyNk3Mht1IP8fCxLWDmRsRNDBiQD9esx+QSQdLEw1ro=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "emiflake";
          repo = "zsh-nix-shell";
          rev = "62659b6805e1e329042efcc5dc1206bfb71a50e3";
          sha256 = "7zrHGlHs68QhsGxcjUtR8UkxyUhiIw7TRkMUQSsayE0=";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
      plugins = [ "git" ];
    };
    initExtra = ''
      ZSH_DISABLE_COMPFIX="true"
      export BAT_THEME=Coldark-Cold
      bindkey -v
      export EDITOR=${pkgs.neovim}/bin/nvim
      export TERM=xterm
      enable-fzf-tab
      export FZF_DEFAULT_OPTS='--color=light'
    '';
    shellAliases =
      let
        eza = "${pkgs.eza}/bin/eza";
      in
      {
        cd = "z";
        cat = "${pkgs.bat}/bin/bat -P --theme=Coldark-Cold";
        ls = eza;
        ll = eza;
        n = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p";
        nm = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/heads/master.zip -p";
        nr = "nix run";
      };
  };
}
