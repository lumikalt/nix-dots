{
  pkgs,
  config,
  lib,
  stylix,
  ...
}: {
  imports = [
    # ./chatting.nix
    ./shell.nix
    ./hyprland.nix
    ./boot.nix
    ./wallpaper.nix
  ];
}
