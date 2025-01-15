{ config, pkgs, ... }:
{
  programs.kitty =
    {
      enable = true;
      font.name = "PragmataPro Mono Liga";

      settings = {
        cursor_trail = 1;
        cursor_trail_decay = "0.05 0.2";
        font_size = 14;
        window_padding_width = 10;
        padding_left = 0;
        padding_top = 0;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        scrollback_lines = 10000;
        repaint_delay = 5;
        sync_to_monitor = false;
      };

      keybindings = {
        "super+equal" = "increase_font_size";
        "super+minus" = "decrease_font_size";
      };

      extraConfig =
        ''
          include Dayfox.conf
        '';
    };
}
