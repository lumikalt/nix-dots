{ pkgs, ... }:
{
  programs.nix-ld.dev.enable = true;

  environment.systemPackages = with pkgs; [
    seahorse
    file-roller # archive manager (used by nemo)
    nemo-with-extensions # file manager
    displaylink
    setxkbmap
    xauth
  ];

  home-manager.users.lumi = {
    services.udiskie = {
      enable = true;
      automount = true;
    };

    services.gpg-agent = {
      enable = true;
      enableFishIntegration = true;
    };

    services.mpris-proxy.enable = true;
  };
}
