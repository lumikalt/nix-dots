{ config, pkgs, wallpaper, ... }: {
  stylix = {
    # wallpaper = config.lib.stylix.mkStaticImage {
    #   image = wallpaper;
    #   polarity = "dark";
    # };
    # wallpaper = config.lib.stylix.make.animation {
    #   animation = wallpaper;
    #   polarity = "dark";
    # };
    image = wallpaper;
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        desktop = 12;
        applications = 12;
        terminal = 12;
        popups = 12;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
    
    opacity.terminal = 0.8;
  };

  home-manager.sharedModules = [{
    stylix.targets.waybar = {
      enableLeftBackColors = true;
      enableRightBackColors = true;
    };
  }];
}
