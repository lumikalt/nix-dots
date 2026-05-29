{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
    enable32Bit = true;
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
  };
}
