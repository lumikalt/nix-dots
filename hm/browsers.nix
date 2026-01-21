{ pkgs, ... }: {
  home.packages = with pkgs; [
    tor-browser
  ];

  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-wayland;
  };
}
