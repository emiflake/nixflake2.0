{ lib, config, pkgs, ... }:
let spectacle = "${pkgs.kdePackages.spectacle}/bin/spectacle";
in {
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "${config.programs.kitty.package}/bin/kitty";
      "super + b" = "${config.programs.firefox.package}/bin/firefox";
      "super + e" = "${config.programs.emacs.package}/bin/emacs";
      "super + space" = "${pkgs.rofi}/bin/rofi -show run";

      "ctrl + shift + 2" = "${spectacle} -tcb";
      "ctrl + shift + 3" = "${spectacle} -fcb";
      "ctrl + shift + 4" = "${spectacle} -rcb";

      # Restarting things
      "super + Escape" = "pkill --signal SIGUSR1 -x sxhkd";
      "super + alt + {q,r}" = "bspc {quit,wm -r}";
      "super + alt + Escape" =
        "pkill -TERM -x polybar && ${pkgs.polybar}/bin/polybar default &";

      "super + {_,shift + }w" = "bspc node -{c,k}";

      # alternate between the tiled and monocle layout
      "super + m" = "bspc desktop -l next";

      # send the newest marked node to the newest preselected node
      "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";

      # swap the current node and the biggest node
      "super + g" = "bspc node -s biggest";

      # set the window state
      "super + {t,shift + t,s,f}" =
        "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

      # set the node flags
      "super + ctrl + {m,x,y,z}" =
        "bspc node -g {marked,locked,sticky,private}";

      # focus the node in the given direction
      "super + {_,shift + }{Left,Down,Up,Right}" =
        "bspc node -{f,s} {west,south,north,east}";

      # focus the node for the given path jump
      "super + {p,b,comma,period}" =
        "bspc node -f @{parent,brother,first,second}";

      # focus the next/previous node in the current desktop
      "super + {_,shift + }c" = "bspc node -f {next,prev}.local";

      # focus the next/previous desktop in the current monitor
      "super + bracket{left,right}" = ''
        D=$(bspc query -D -d); \
          M=$(bspc query -M -m {prev,next}); \
          bspc desktop -m $M; \
          bspc query -m $M -T | jshon -e desktops -a -e name -u | sort -n | xargs bspc monitor $M -o; \
          bspc desktop -f $D'';

      # focus the last node/desktop
      "super + {grave,Tab}" = "bspc {node,desktop} -f last";

      # focus the older or newer node in the focus history
      "super + {o,i}" = ''
        bspc wm -h off; \
          bspc node {older,newer} -f; \
          bspc wm -h on'';

      # focus or send to the given desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

      # preselect the direction
      "super + ctrl + {Left,Down,Up,Right}" =
        "bspc node -p {west,south,north,east}";

      # preselect the ratio
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

      # cancel the preselection for the focused node
      "super + ctrl + space" = "bspc node -p cancel";

      # cancel the preselection for the focused desktop
      "super + ctrl + shift + space" =
        "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

      # expand a window by moving one of its side outward
      "super + alt + {Left,Down,Up,Right}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

      # contract a window by moving one of its side inward
      "super + alt + shift + {Left,Down,Up,Right}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

    };
  };
}
