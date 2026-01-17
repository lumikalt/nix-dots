{ pkgs, ... }: {
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      default-timeout = 5000;
    };
  };

  services.poweralertd.enable = true;

  systemd.user.services = {
    # pipewire.wantedBy = ["default.target"];
    pipewire-pulse = {
      # path = [ pkgs.pulseaudioFull ];
      # wantedBy = ["default.target"];
    };
  };

  # systemd.user.services.mpris-proxy = {
  #   description = "Mpris proxy";
  #   after = [ "network.target" "sound.target" ];
  #   wantedBy = [ "default.target" ];
  #   serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  # };

  qt = {
    enable = true;
  };

  gtk = {
    enable = true;
    
    iconTheme.name = "Papyrus";

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
}
