{ lib, config, theme, pkgs, ... }:

let
  font = "PragmataPro Liga";
  fontSize = "30";
in
{
  programs.rofi.enable = true;

  xdg = {
    enable = true;
    configFile = {
      "rofi/config.rasi".text = let theme = config.user-theme; in
        ''
          * {
            red:        ${theme.red};
            blue:       ${theme.blue};
            cyan:       ${theme.cyan};
            purple:     ${theme.magenta};
            emphasis:   ${theme.base0};
            text:       ${theme.fg};
            text-alt:   ${theme.fg};
            bg:         ${theme.bg};

            spacing: 0;
            background-color: transparent;

            font: "${font} ${fontSize}";
            text-color: @text;
          }

          window {
            transparency: "real";
            fullscreen: true;
            background-color: @bg;
          }

          mainbox {
            padding: 30% 30%;
          }

          inputbar {
            margin: 0px 0px 20px 0px;
            children: [prompt, textbox-prompt-colon, entry, case-indicator];
          }

          prompt {
            text-color: @text;
          }

          textbox-prompt-colon {
            expand: false;
            str: ":";
            text-color: @text-alt;
          }

          entry {
            margin: 0px 10px;
          }

          listview {
            spacing: 5px;
            dynamic: true;
            scrollbar: false;
          }

          element {
            padding: 5px;
            text-color: @text-alt;
            highlight: bold #4DB5BD; // On grep
            border-radius: 3px;
          }

          element selected {
            background-color: @emphasis;
            text-color: @text;
          }

          element urgent, element selected urgent {
            text-color: @red;
          }

          element active, element selected active {
            text-color: @emphasis;
          }

          message {
            padding: 5px;
            border-radius: 3px;
            background-color: @emphasis;
            border: 1px;
            border-color: @cyan;
          }

          button selected {
            padding: 5px;
            border-radius: 3px;
            background-color: @emphasis;
          }
        '';
    };
  };
}
