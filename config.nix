{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];

      # Haskell
      # trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
      # substitutors = ["https://cache.iog.io"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "10m";
    };
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "wumi";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "pt-latin1";

  users.users.lumi = {
    description = "Lumi Kalt";
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "networkmanager"];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    fish
    neovim
    nixUnstable # flakes etc.
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.dbus.implementation = "broker";

  systemd.services.systemd-journal-flush.enable = false;

  zramSwap.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = [pkgs.vaapiIntel];
    driSupport32Bit = true;
  };

  system.stateVersion = "23.05";
}
