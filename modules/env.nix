{ pkgs, ... }: {
  services.mako = {
    enable = true;

    anchor = "top-right";
    defaultTimeout = 5000;
  };

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

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
    gtk.enable = true;
  };
}
