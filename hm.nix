{ lib, ... }:
{
  home.username = "lumi";
  home.homeDirectory = lib.mkForce /home/lumi;
  home.stateVersion = "25.11";

  imports = [ ./hm ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;
}
