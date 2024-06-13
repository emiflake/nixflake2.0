{ config, pkgs, ... }:
{
  # What packages are allowed to be unfree?
  # In other words, below is a list of packages that are unfree that are
  # installable anyway.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "discord"
    "slack"
    "spotify"
    "spotify-unwrapped"
    "steam"
    "steam-original"
  ];
}
