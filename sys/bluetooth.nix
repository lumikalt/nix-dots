{ pkgs-stable, ... }:
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
    package = pkgs-stable.pipewire;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber = {
      package = pkgs-stable.wireplumber;
    };
  };

  services.blueman.enable = true;
}
