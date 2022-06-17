# This module is responsible for desktop apps
{ config, pkgs, inputs, ... }:
{
  programs.firefox.enable = true;

  home.packages =
    with pkgs; [
      discord
      slack
      spotify
      steam
      polymc
      yubikey-personalization-gui
      yubioath-desktop
      ledger-live-desktop
      pavucontrol
      vlc
      audacity
    ];
}
