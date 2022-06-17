{ config, pkgs, ... }:
{
  config.programs.kitty =
    {
      enable = true;
      font.name = "PragmataPro Mono Liga";

      settings = {
        font_size = 18;
        window_padding_width = 20;
        enable_audio_bell = false;
      };

      keybindings = {
        "super+equal" = "increase_font_size";
        "super+minus" = "decrease_font_size";
      };

      extraConfig =
        let theme = config.user-theme; in
        ''
          foreground ${theme.fg}
          background ${theme.bg}
          color0 ${theme.bg}
          color1 ${theme.red}
          color2 ${theme.green}
          color3 ${theme.yellow}
          color4 ${theme.blue}
          color5 ${theme.violet}
          color6 ${theme.cyan}
          color7 #e0dce0
          color8 #474247
          color9 ${theme.red}
          color10 ${theme.green}
          color11 ${theme.yellow}
          color12 ${theme.blue}
          color13 ${theme.violet}
          color14 ${theme.cyan}
          color15 ${theme.fg}
        '';
    };
}
