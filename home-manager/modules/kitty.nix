{ config, pkgs, ... }:
{
  programs.kitty =
    {
      enable = true;
      font.name = "PragmataPro Mono Liga";

      settings = {
        font_size = 14;
        window_padding_width = 10;
        padding_left = 0;
        padding_top = 0;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        scrollback_lines = 10000;
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
