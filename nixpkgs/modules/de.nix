# This module is primarily responsible for 
# setting up the desktop environment on a NixOS machine
# that doesn't manage its own DE through other means.
{ config, pkgs, ... }:
{
  imports = [
    ./sxhkd.nix
    ./polybar.nix
    ./bspwm.nix
    ./rofi.nix
  ];

  # This sort of patches everything together to make it magically work.
  home.file.".xinitrc".text = ''
    echo "de.nix startup procedure"
    ${config.services.sxhkd.package}/bin/sxhkd &
    xsetroot -cursor_name left_ptr &
    BG="$HOME/Pictures/doom-themed wallpaper-red.png"
    ${pkgs.feh}/bin/feh --bg-fill "$BG" &
    ${config.services.polybar.package}/bin/polybar default &
    ${pkgs.picom}/bin/picom --shadow --vsync &
    sleep 1 && sh ~/.config/bspwm/bspwmrc &
    exec ${config.xsession.windowManager.bspwm.package}/bin/bspwm
  '';
}
