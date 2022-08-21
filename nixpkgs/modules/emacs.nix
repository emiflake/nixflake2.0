{ config, pkgs, libs, inputs, system, ... }:
{
  programs.emacs = {
    enable = true;
  };

  home.file.".doom.d/init.el".text = builtins.readFile ./emacs/init.el;
  home.file.".doom.d/config.el".text = builtins.readFile ./emacs/config.el;
}
