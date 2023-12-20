{ pkgs, ... }: {
  home.packages = with pkgs; [
    tor-browser-bundle-bin
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };
}
