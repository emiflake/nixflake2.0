{ config, pkgs, libs, inputs, system, ... }:

let
  unison-git = pkgs.fetchFromGitHub {
    owner = "unisonweb";
    repo = "unison";
    rev = "e7023cd54b7f8cb2fc606f244607016e7776fdc2";
    sha256 = "YTDQm86ccbHyeo4RHnmqKkJod1Bs4cY5KzGxVCusOpo=";
  };
  unison-src = pkgs.runCommand "unison-src" { } ''
    cp -r ${unison-git}/editor-support/vim $out
  '';
  unison = pkgs.vimUtils.buildVimPlugin {
    name = "unison";
    src = unison-src;
  };

in {

  systemd.user.services.ra-multiplex = {
    Unit = { Description = "Persistent rust analyzer"; };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.ra-multiplex}/bin/ra-multiplex server";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  home.packages = [
    inputs.rnix-lsp.defaultPackage.${system}
    pkgs.nixfmt
    pkgs.efm-langserver
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    package = pkgs.neovim-unwrapped;
  };
}
