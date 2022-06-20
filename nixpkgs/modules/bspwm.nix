# The bspwm window manager home-manager module
{ lib, config, pkgs, ... }:
{
  xsession = {
    enable = true;
    # windowManager.command = "${config.xsession.windowManager.bspwm.package}/bin/bspwm";
  };

  home.packages = [ config.xsession.windowManager.bspwm.package ];

  xdg = {
    enable = true;
    configFile = {
      "bspwm/bspwmrc".text = ''
        #!/bin/sh
        bspc monitor -d I II III IV V VI VII VIII IX X
        bspc config border_width         0
        bspc config window_gap           48
        bspc config split_ratio          0.52
        bspc config borderless_monocle   true
        bspc config gapless_monocle      true
        bspc rule -a Emacs state=tiled
      '';
    };
  };
}




