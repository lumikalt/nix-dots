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
      extraEnv = {
        SDL_VIDEODRIVER = "wayland,x11";
      };

      extraPkgs =
        pkgs: with pkgs; [
          mesa-demos
          jdk
        ];
    };
  };

  environment.systemPackages = [ pkgs.wineWow64Packages.staging ];
}
