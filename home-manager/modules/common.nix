{ pkgs, inputs, system, ... }: {
  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  # programs.direnv.nix-direnv.package =
  #   (import inputs.nixpkgs-latest { inherit system; }).nix-direnv;

  home.packages = with pkgs; [
    wget
    du-dust
    bash
    docker
    coreutils
    ripgrep
    (import inputs.nixpkgs-latest { inherit system; }).nix
    fzf
    fd
    nil # Nix LSP
    github-cli
    file
    cachix
    notmuch
    offlineimap
    ispell
    nixpkgs-fmt
    xclip
    tree-sitter
    oha
  ];

  home.file = {
    ".ghci".text = ''
      :set prompt ">λ= "
      :set +s
    '';

    ".haskeline".text = ''
      editMode: Vi
    '';
  };

  programs.jq.enable = true;
  programs.htop.enable = true;
}
