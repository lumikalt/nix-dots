{ pkgs, ... }:
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
      carlito
      ipafont
      kochi-substitute
      ttf_bitstream_vera
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
          "IPAPGothic"
          "Unifont"
        ];
        serif = [
          "TT2020Base"
          "Noto Serif"
          "IPAPMincho"
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
