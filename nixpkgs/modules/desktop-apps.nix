# This module is responsible for desktop apps
{ config, pkgs, inputs, ... }:
let custom-discord =
  pkgs.discord.overrideAttrs (_: {
    version = "0.0.20";
    src = builtins.fetchTarball {
      url = "https://dl.discordapp.net/apps/linux/0.0.20/discord-0.0.20.tar.gz";
      sha256 = "0qaczvp79b4gzzafgc5ynp6h4nd2ppvndmj6pcs1zys3c0hrabpv";
    };
  });
in
{
  # programs.firefox.enable = true;

  home.packages =
    with pkgs; [
      firefox
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
