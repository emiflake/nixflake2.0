# A theme format for use in desktop applications and editors  
{ lib, config, pkgs, ... }:
let
  colour = lib.mkOptionType {
    name = "colour";
    description = "hex colour";
    check = s: lib.types.str.check s && builtins.match "#[0-9a-fA-F]{6}" s != null;
  };

  mkColourOption = name: default: (lib.mkOption {
    type = colour;
    description = "The colour value for the name '${name}'.";
    inherit default;
  });
in
{
  # The default theme is one-dark.
  options.user-theme = builtins.mapAttrs mkColourOption rec {
    bg = "#282c34";
    bg-alt = "#21242b";
    base0 = "#1B2229";
    base1 = "#1c1f24";
    base2 = "#202328";
    base3 = "#23272e";
    base4 = "#3f444a";
    base5 = "#5B6268";
    base6 = "#73797e";
    base7 = "#9ca0a4";
    base8 = "#DFDFDF";
    fg = "#bbc2cf";
    fg-alt = "#5B6268";
    grey = base4;
    red = "#ff6c6b";
    orange = "#da8548";
    green = "#98be65";
    teal = "#4db5bd";
    yellow = "#ECBE7B";
    blue = "#51afef";
    dark-blue = "#2257A0";
    magenta = "#c678dd";
    violet = "#a9a1e1";
    cyan = "#46D9FF";
    dark-cyan = "#5699AF";
  };
}
