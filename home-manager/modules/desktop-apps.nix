# This module is responsible for desktop apps
{ config, pkgs, inputs, system, ... }:
let
  custom-discord = pkgs.discord.overrideAttrs (_: rec { version = "0.0.22"; });
in {
  # programs.firefox.enable = true;

  home.packages = with pkgs; [
    firefox
    custom-discord
    slack
    spotify
    yubikey-personalization-gui
    (import inputs.nixpkgs-pin1 { inherit system; }).yubioath-desktop
    ledger-live-desktop
    pavucontrol
    vlc
    audacity
    (import inputs.nixpkgs-latest { inherit system; }).signal-desktop
    libreoffice
    runelite
    obsidian
    telepresence2
    chromium
    # (inputs.plover-flake.packages.${system}.plover.with-plugins (ps:
    #   [
    #     ps.plover_stitching
    #     ps.plover_dict_commands
    #     ps.plover_last_translation
    #     ps.plover-modal-dictionary
    #     ps.plover_python_dictionary
    #     ps.plover_retro_surround
    #   ]
    # ))
    libsForQt5.kleopatra
    steam
    xonotic
    (import ../cpma.nix { inherit pkgs; })
  ];
}
