{ pkgs, ... }: {
  services.mako = {
    enable = true;

    anchor = "top-right";
    defaultTimeout = 5000;
  };

  services.poweralertd.enable = true;

  # systemd.user.services = {
  #   pipewire.wantedBy = ["default.target"];
  #   pipewire-pulse = {
  #     path = [ pkgs.pulseaudio ];
  #     wantedBy = ["default.target"];
  #   };
  # };

  qt = {
    enable = true;

    platformTheme = "gtk";
  };

  gtk = {
    enable = true;
    
    iconTheme.name = "Papyrus";

    # Actual color theme should be managed by stylix.

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
