{
  imports = [
    ./hardware-configuration.nix # nixOS default
    ./sys
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;

      builders-use-substitutes = true;

      allowed-users = [ "lumi" ];
      trusted-users = [ "lumi" ];
    };

    gc = {
      # automatic = true;
      dates = "weekly";
      randomizedDelaySec = "10m";
      options = "--delete-older-than 7d";
    };
  };

  zramSwap.enable = true;

  system.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;

}
