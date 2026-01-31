{
  hardware.bluetooth = {
    enable = true;

    settings.General = {
      Experimental = true;
    };
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;
}
