{ pkgs, ... }:
{
  imports = [
    ./modules
  ];

  time.timeZone = "Europe/Lisbon";
  # Fix for Windows time.
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "pt-latin1";

  users.users.lumi = {
    description = "lumi";
    isNormalUser = true;
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

  programs.light.enable = true;

  programs.fish.enable = true;

  programs.nix-index.enable = true;

  programs.command-not-found.enable = false;

  environment.systemPackages = with pkgs; [
    gitFull
    fish
    nushell
    nixVersions.latest
    helix
    seahorse # gnome-keyring gui
    wlr-randr
    displaylink
    wineWowPackages.staging
  ];
}
