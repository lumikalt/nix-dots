{ pkgs, ... }:
{
  home.packages = with pkgs; [
    revolt-desktop # stoat isn't named correctly
    signal-desktop
    wasistlos # whatsapp
  ];

  programs.vesktop = {
    enable = true;
  };
}
