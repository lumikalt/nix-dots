{ pkgs, ... }:
{
  programs.java.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          mesa-demos
          jdk
        ];
    };
  };

  environment.systemPackages = [
    pkgs.wineWow64Packages.staging
    # PPSSPP core for PSP games (e.g. LocoRoco 2).
    (pkgs.retroarch.withCores (cores: [ cores.ppsspp ]))
  ];

  # Android container, for games with no native Linux build (e.g. Arknights).
  virtualisation.waydroid.enable = true;
}
