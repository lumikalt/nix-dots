{ pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix # nixOS default
    ./sys
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;

      builders-use-substitutes = true;
      
      trusted-users = [ "lumi" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "10m";
      options = "--delete-older-than 7d";
    };
  };

  zramSwap.enable = true;

  system.stateVersion = "23.11";

  programs.adb.enable = true;

  ### user

  time.timeZone = "Europe/Lisbon";
  # Fix for Windows time.
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "pt-latin1";

  users.users.lumi = {
    description = "Lumi Kalt";
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" "power" "nix" "adbusers" ];
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
    neovim
    # nixUnstable # flakes etc.
    nixVersions.latest
    gnome.seahorse # gnome-keyring gui
  ];

  nixpkgs.config.allowUnfree = true;
}
