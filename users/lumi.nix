{ pkgs, ... }:
{
  imports = [ ./../modules ];
  
  users.users.lumi = {
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "networkmanager"
      "power"
      "nix"
      "adbusers"
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    fish
    nushell
    nixVersions.latest
    helix
    seahorse
    wlr-randr
    displaylink
    wineWowPackages.staging
  ];

  programs.light.enable = true;

  programs.fish.enable = true;

  programs.nix-index.enable = true;

  programs.command-not-found.enable = false;

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  niri-flake.cache.enable = true;
  
  programs.nix-ld.dev.enable = true;

  home-manager.users.lumi = {

  };
}
