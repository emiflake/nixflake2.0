# This module is primarily responsible for
# setting up the desktop environment on a NixOS machine
# that doesn't manage its own DE through other means.
{ config, pkgs, inputs, system, ... }: {
  imports = [ ./sxhkd.nix ./polybar.nix ./bspwm.nix ./rofi.nix ];

  xsession = {
    enable = true;
    windowManager.command = "[[ -f ~/.profile ]] && . ~/.profile";
  };

  # This sort of patches everything together to make it magically work.
  home.file.".xinitrc".text = let
    bspwmrc = pkgs.writeText "bspwmrc" ''
      #!/bin/sh
      bspc monitor \^1 -d I II III IV V VI VII VIII IX X
      bspc config border_width         0
      bspc config window_gap           48
      bspc config split_ratio          0.52
      bspc config borderless_monocle   true
      bspc config gapless_monocle      true
      bspc rule -a Emacs state=tiled
    '';
  in ''
    echo "de.nix startup procedure"
    xrandr --output DP-2 --primary --mode 2560x1440 --output HDMI-0 --mode 2560x1440 --pos 2560x0
    ${config.services.sxhkd.package}/bin/sxhkd &
    xsetroot -cursor_name left_ptr & 
    ${pkgs.feh}/bin/feh --bg-fill "${../assets/wallpaper-light-rabbit.png}" &
    # This version actually works :)
    ${pkgs.picom}/bin/picom --vsync --shadow --shadow-radius 20 --shadow-opacity 0.2 --blur-background --blur-size 2 --blur-method box --blur-strength 2 &
    sleep 1 && sh ${bspwmrc} &
    ${config.services.polybar.package}/bin/polybar default &
    exec ${config.xsession.windowManager.bspwm.package}/bin/bspwm
  '';
}
