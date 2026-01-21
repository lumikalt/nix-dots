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
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
        RADV_TEX_ANISO = 16;
        SDL_VIDEODRIVER = "wayland,x11";
      };

      extraPkgs =
        pkgs: with pkgs; [
          bumblebee
          mesa-demos
          jdk
        ];
    };
  };
}
