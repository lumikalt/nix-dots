{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      default-timeout = 5000;
    };
  };

  services.poweralertd.enable = true;

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
