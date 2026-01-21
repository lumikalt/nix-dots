{ pkgs }:
{
  home.packages = with pkgs; [
    revolt-desktop
    signal-desktop
  ];

  programs.vesktop = {
    enable = true;
  };
}
