{ config, pkgs, ... }: {
  config.services.polybar = let
    selected = config.user-theme.dark-cyan;
    lightgray = config.user-theme.violet;
    emphasis = config.user-theme.red;
    foreground = config.user-theme.fg;
    background = config.user-theme.bg;
  in {
    enable = true;
    script = "polybar default &";

    config = {
      "module/menu" = {
        type = "custom/text";

        click-left = "rofi -show run";

        content = "Menu";
      };

      "bar/default" = {
        enable-ipc = true;

        width = "100%";
        height = 36;
        padding-left = 6;
        padding-right = 6;

        radius = "0.0";

        offset-x = "0%";
        fixed-center = false;

        background = background;
        foreground = foreground;

        line-size = 3;
        line-color = emphasis;

        font-0 = "PragmataPro Liga:pixelsize=13";
        font-1 = "Noto Color Emoji:scale=10:style=Regular";

        tray-position = "none";
        tray-padding = 1;
        tray-maxsize = 16;

        module-margin-left = 1;
        module-margin-right = 1;
        separator = "   ";

        modules-left = "bspwm xwindow";
        modules-right = "mpd_current_song cpu mem date";

        scroll-up = "bspwm-desknext";
        scroll-down = "bspwm-deskprev";

        wm-restack = "bspwm";
      };

      "module/bspwm" = {
        type = "internal/bspwm";

        label-focused = "%index%";
        label-focused-foreground = selected;
        label-focused-background = background;
        label-focused-underline = selected;
        label-focused-padding = 1;

        label-occupied = "%index%";
        label-occupied-foreground = lightgray;
        label-occupied-padding = 1;

        label-urgent = "%index%!";
        label-urgent-background = emphasis;
        label-urgent-padding = 1;

        label-empty = "%index%";
        label-empty-foreground = lightgray;
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        format-foreground = foreground;
        label = "%title%";
        label-maxlen = 100;
      };

      # "module/mpd_current_song" = {
      #   type = "custom/script";
      #   exec = "mpc status | head -n 1 | xargs -0 -I{} basename {} | sed -E 's|([^\\.]+)\\..*|\\1|'";
      #   exec-if = "pgrep -x mpd";
      #   interval = 5;
      # };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU ";
        label = "%percentage%%";
      };

      "module/mem" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM ";
        label = "%percentage_used%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;

        date = "y%Ym%md%d";
        time = "%H:%M:%S";

        label = "%time% %date%";
      };
    };
  };
}
