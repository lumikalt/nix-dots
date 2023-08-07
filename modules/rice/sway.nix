{ config, pkgs, lib, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "bemenu";

      startup = [
        # { command = "systemctl --user restart waybar"; always = true; }
      ];

      keybinds = let
        m = "Mod4";
        t = "kitty";
      in {
        "${m}+Return" = "exec ${t}";
        "${m}+q" = "kill";
        "${m}+d" = "exec bemenu-run -p \"run: \"";
        "${m}+s" = "floating toggle";
        "${m}+w" = "exec firefox";
        "${m}+a" = "exec code";
        "Print" = "exec grimblast --notify copy area";
        "Shift+Print" = "exec grimblast --notify copysave area";
        "${m}+l" = "exec swaylock";
        "${m}+c" = "exec hyprpicker -ar && notify-send -u critical -t 4000 \"$(wl-paste)\"";
      };

      gaps = {
        smartBorders = "on";
        outer = 5;
        inner = 3;
      };

      input = {
        "type:touchpad" = {
          middle_emulation = "enabled";
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };
    };

    wrapperFeatures.gtk = true;
  };
}