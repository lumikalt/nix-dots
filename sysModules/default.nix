{ config, pkgs, lib, ... }: {
  imports = [
    ./boot.nix
    ./hyprland.nix
  ];
}
