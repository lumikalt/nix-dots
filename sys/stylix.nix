{ pkgs, wallpaper, ... }:
{
  stylix = {
    enable = true;
    image = wallpaper;
    polarity = "light";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";

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
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
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

    # opacity.terminal = 0.8;
  };

  home-manager.sharedModules = [
    {
      stylix.targets = {
        waybar = {
          enableLeftBackColors = true;
          enableRightBackColors = true;
        };

        # VS Code replaces the managed settings.json symlink, breaking activation.
        vscode.enable = false;

        # Vesktop gets a hand-written theme instead.
        vesktop.enable = false;

        firefox = {
          profileNames = [ "default" ];
          firefoxGnomeTheme.enable = true;
        };

        # Not used; avoids an upstream rename warning (programs.rofi.font).
        rofi.enable = false;

        # Keep the custom helix theme.
        # helix.enable = false;
      };
    }
  ];
}
