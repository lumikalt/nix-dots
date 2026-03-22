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
      "docker"
    ];
  };

  environment.systemPackages = [ pkgs.nixVersions.latest ];

  home-manager.users.lumi = {
    home.username = "lumi";
    home.stateVersion = "26.05";
    fonts.fontconfig.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}
