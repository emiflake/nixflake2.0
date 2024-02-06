{ config, pkgs, libs, inputs, system, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };
}
