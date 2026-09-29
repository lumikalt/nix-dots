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

    wireplumber = {
      extraConfig."51-deprioritize-thinkpad-dock-audio" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                # The DisplayLink dock's USB audio otherwise outranks the
                # internal speakers (USB devices get a priority bonus) and
                # keeps grabbing the default sink whenever it's plugged in.
                "node.name" = "~alsa_output.usb-DisplayLink_ThinkPad_Hybrid_USB-C_with_USB-A_Dock.*";
              }
            ];
            actions = {
              update-props = {
                "priority.session" = 200;
                "priority.driver" = 200;
              };
            };
          }
        ];
      };
    };
  };

  services.blueman.enable = true;
}
