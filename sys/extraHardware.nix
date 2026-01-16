{ pkgs, ... }: {
  # Just cause.
  hardware.enableAllFirmware = true;

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

  hardware.bluetooth = {
    enable = true;

    # settings.General = {
    #   Enable = "Source,Sink,Media,Socket";
    # };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
  };
}
