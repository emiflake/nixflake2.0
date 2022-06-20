# This module is primarily responsible for 
# setting up the desktop environment on a NixOS machine
# that doesn't manage its own DE through other means.
{ config, pkgs, inputs, system, ... }:
{
  imports = [
    ./sxhkd.nix
    ./polybar.nix
    ./bspwm.nix
    ./rofi.nix
  ];


  xsession = {
    enable = true;
    windowManager.command = "[[ -f ~/.profile ]] && . ~/.profile";
  };

  # This sort of patches everything together to make it magically work.
  home.file.".xinitrc".text =
    let
      bspwmrc = pkgs.writeText "bspwmrc" ''
        #!/bin/sh
        bspc monitor -d I II III IV V VI VII VIII IX X
        bspc config border_width         0
        bspc config window_gap           48
        bspc config split_ratio          0.52
        bspc config borderless_monocle   true
        bspc config gapless_monocle      true
        bspc rule -a Emacs state=tiled
      '';
    in
    ''
      echo "de.nix startup procedure"
      ${config.services.sxhkd.package}/bin/sxhkd &
      xsetroot -cursor_name left_ptr &
      ${pkgs.feh}/bin/feh --bg-fill "${../assets/doom-themed-wallpaper-red.png}" &
      ${config.services.polybar.package}/bin/polybar default &
      # This version actually works :)
      ${(import inputs.nixpkgs-21_11 { localSystem = system; }).picom}/bin/picom --shadow --vsync &
      sleep 1 && sh ${bspwmrc} &
      exec ${config.xsession.windowManager.bspwm.package}/bin/bspwm
    '';
}
