{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts noto-fonts-cjk noto-fonts-emoji
      unifont symbola
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      material-icons emacs-all-the-icons-fonts
    ];

    enableDefaultPackages = true;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "Material Icon"
          "FontAwesome"
          "all-the-icons"
        ];
        sansSerif = [ "Noto Sans" "Unifont"];
        serif = [ "Noto Sans" "Unifont" ];
        emoji = [
          "Noto Color Emoji"
          "Symbola"
          "all-the-icons"
        ];
      };
    };
  };
}