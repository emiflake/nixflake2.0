{ config, pkgs, libs, ... }: {

  home.packages = with pkgs; [ bat ];
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
        name = "zsh-fzf-history-search";
        src = pkgs.fetchFromGitHub {
          owner = "joshskidmore";
          repo = "zsh-fzf-history-search";
          rev = "d5a9730b5b4cb0b39959f7f1044f9c52743832ba";
          sha256 = "sha256-tQqIlkgIWPEdomofPlmWNEz/oNFA1qasILk4R5RWobY=";
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
      bindkey -v

      export PATH="$PATH:$HOME/.nix-profile/bin"
      export BAT_THEME=Coldark-Dark
      export EDITOR=${pkgs.neovim}/bin/nvim
      export TERM=xterm
      enable-fzf-tab
      export FZF_DEFAULT_OPTS='--color=dark'
    '';
    shellAliases = let eza = "${pkgs.eza}/bin/eza";
    in {
      cd = "z";
      cat = "${pkgs.bat}/bin/bat -P --theme=Coldark-Dark --decorations=never";
      ls = eza;
      ll = eza;
      vim = "nvim";
      n = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p";
      nm =
        "NIXPKGS_ALLOW_UNFREE=1 nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/heads/master.zip -p";
      nr = "nix run";
    };
  };
}
