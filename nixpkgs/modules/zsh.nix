{ config, pkgs, libs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    plugins = [
      {
        name = "zsh-z";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "e138de57cd59ed09c3d55ff544ff8f79d2dc4ac1";
          sha256 = "02b3r4bv8mz16xqngpi2353gv8fb478fwy10786i9j3ymp4hql5j";
        };
      }
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
      theme = "refined";
      plugins = [ "git" ];
    };
    initExtra = ''
      ZSH_DISABLE_COMPFIX="true"
      bindkey -v
      export EDITOR=${pkgs.neovim}/bin/nvim
      export TERM=xterm
    '';
    shellAliases =
      let
        exa = "${pkgs.exa}/bin/exa";
      in
      {
        ls = exa;
        ll = exa;
        n = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p";
        nm = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/heads/master.zip -p";
        nr = "nix run";
      };
  };
}
