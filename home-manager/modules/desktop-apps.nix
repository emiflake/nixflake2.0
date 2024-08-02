# This module is responsible for desktop apps
{ config, pkgs, inputs, system, ... }:
let
  custom-discord = pkgs.discord.overrideAttrs (_: rec {
    version = "0.0.22";
    src = builtins.fetchTarball {
      url =
        "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "1z980p3zmwmy29cdz2v8c36ywrybr7saw8n0w7wlb74m63zb9gpi";
    };
  }); 
in
{
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
    telepresence2
    (inputs.plover-flake.packages.${system}.plover.with-plugins (ps:
      [
        ps.plover_stitching
        ps.plover_dict_commands
        ps.plover_last_translation
        ps.plover-modal-dictionary
        ps.plover_python_dictionary
        ps.plover_retro_surround
      ]
    ))
    kleopatra

    steam
    xonotic
    (import ../cpma.nix { inherit pkgs; })
  ];
}
