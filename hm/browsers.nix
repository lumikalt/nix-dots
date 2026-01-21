{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tor-browser
  ];

  programs.firefox = {
    enable = true;
  };
}
