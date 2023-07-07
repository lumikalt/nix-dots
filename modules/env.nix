{ config, pkgs, lib, ... }: {
  services.mako = {
    enable = true;

    anchor = "top-right";
    defaultTimeout = 5000;
  };
}