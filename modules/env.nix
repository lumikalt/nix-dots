{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;

    plugins = with pkgs; with pkgs.xfce; [
      thunar-volman
      thunar-vcs-plugin
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };

  programs.nix-ld.dev.enable = true;

  environment.systemPackages = with pkgs; [
    seahorse
    displaylink
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
