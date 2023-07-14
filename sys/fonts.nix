{ pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      noto-fonts noto-fonts-cjk noto-fonts-emoji
      unifont symbola maple-mono
      (nerdfonts.override { fonts = [ "Hasklig" ]; })
      material-icons emacs-all-the-icons-fonts
    ];

    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Code D OnePiece"
          "Hasklug Nerd Font" # ... why is it not the same name.
          "Noto Color Emoji"
        ];
        sansSerif = [ "Code D Haki" "Noto Sans" "Unifont"];
	      serif = [ "Code D Ace" "Noto Sans" "Unifont" ];
	      emoji = [ "Noto Color Emoji" "Code D Lip" "Symbola" "Noto Sans" "Unifont" ];
      };
    };
  };
}