{ config, pkgs, lib, ... }: {
  # Fallback
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";

      startup = [
        { command = "systemctl --user restart waybar"; always = true; }
      ]
    };
  };
}