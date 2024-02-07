{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    /home/emi/.config/nixos/fonts/PragmataPro-Regular0.830/PragmataPro_Mono_R_0830.ttf
    /home/emi/.config/nixos/fonts/PragmataPro-Regular0.830/PragmataPro_Mono_R_liga_0830.ttf
    /home/emi/.config/nixos/fonts/PragmataPro-Regular0.830/PragmataProR_0830.ttf
    /home/emi/.config/nixos/fonts/PragmataPro-Regular0.830/PragmataProR_liga_0830.ttf
  ];
}
