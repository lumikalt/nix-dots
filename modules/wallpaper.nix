{ pkgs, ... }: {
  stylix = {
    image = ../assets/wallpapers/wallpaper.png;
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
        package = (pkgs.nerdfonts.override { fonts = [ "Hasklig" ]; });
        name = "Hasklug Nerd Font";
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
    opacity.terminal = 0.8;
  };

  home-manager.sharedModules = [{
    stylix.targets.waybar = {
      enableLeftBackColors = true;
      enableRightBackColors = true;
    };
  }];
}
