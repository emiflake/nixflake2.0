# This module is responsible for desktop apps
{ config, pkgs, inputs, ... }:
let custom-discord =
  pkgs.discord.overrideAttrs (_: {
    version = "0.0.19";
    src = builtins.fetchTarball {
      url = "https://dl.discordapp.net/apps/linux/0.0.19/discord-0.0.19.tar.gz";
      sha256 = "sha256:1kwqn1xr96kvrlbjd14m304g2finc5f5ljvnklg6fs5k4avrvmn4";
    };
  });
in
{
  programs.firefox.enable = true;

  home.packages =
    with pkgs; [
      custom-discord
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
