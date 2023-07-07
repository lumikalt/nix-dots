{ config, pkgs, lib, ... }: {
  fonts = {
    fonts = with pkgs; [
      noto-fonts unifont
      symbola noto-fonts-emoji maple-mono
      (nerdfonts.override { fonts = [ "Hasklig" ]; })
    ];

    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Code D OnePiece"
          "Hasklig"
          "Noto Color Emoji"
        ];
        sansSerif = [ "Code D Haki" "Noto Sans" "Unifont"];
	      serif = [ "Code D Ace" "Noto Sans" "Unifont" ];
	      emoji = [ "Noto Color Emoji" "Code D Lip" "Symbola" "Noto Sans" "Unifont" ];
      };
    };
  };
}