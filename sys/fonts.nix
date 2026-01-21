{ pkgs }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      unifont
      symbola
      nerd-fonts.jetbrains-mono
      material-icons
      emacs-all-the-icons-fonts
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
        sansSerif = [
          "Noto Sans"
          "Unifont"
        ];
        serif = [
          "Noto Sans"
          "Unifont"
        ];
        emoji = [
          "Noto Color Emoji"
          "Symbola"
          "all-the-icons"
        ];
      };
    };
  };
}
