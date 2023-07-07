{ config, pkgs, lib, ... }: {
  # Fallback if needed
  wayland.windowManager.sway = {
    enable = true;
    config.terminal = "kitty";
  };
}