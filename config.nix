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

      builders-use-substitutes = true;
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


  ### user

  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "pt-latin1";

  users.users.lumi = {
    description = "Lumi Kalt";
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" "power" "nix" ];
    shell = pkgs.fish;
  };


  programs.light.enable = true;

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    gitFull
    fish
    neovim
    nixUnstable # flakes etc.
  ];

  nixpkgs.config.allowUnfree = true;
}
