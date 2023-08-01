{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts noto-fonts-cjk noto-fonts-emoji
      unifont symbola
      (nerdfonts.override { fonts = [ "Hasklig" ]; })
      material-icons emacs-all-the-icons-fonts
    ];

    enableDefaultPackages = true;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Hasklug Nerd Font" # ... why is it not the same name.
          "Unifont"
          "Material Icon"
          "FontAwesome"
          "all-the-icons"
        ];
        sansSerif = [ "Noto Sans" "Unifont"];
        serif = [ "Noto Sans" "Unifont" ];
        emoji = [
          "Noto Color Emoji"
          "Symbola"
          "Unifont"
          "Material Icon"
          "FontAwesome"
          "all-the-icons"
        ];
      };
    };
  };
}