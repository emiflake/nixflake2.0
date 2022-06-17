{ lib, config, pkgs, ... }:
with lib;
{
  options.user-options.packages.terminal = mkOption {
    type = lib.types.str;
    default = "${pkgs.kitty}/bin/kitty";
  };

  options.user-options.packages.browser = mkOption {
    type = lib.types.str;
    default = "${pkgs.firefox}/bin/firefox";
  };
}
