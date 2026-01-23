{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tor-browser
    w3m
  ];

  programs.firefox = {
    enable = true;
  };

  programs.floorp = {
    enable = true;
  };
}
