{ config, pkgs, lib, ... }: {
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
    ];
    driSupport32Bit = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}