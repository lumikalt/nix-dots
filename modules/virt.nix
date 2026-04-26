{ pkgs, pkgs-stable, ... }:
{
  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    # package = pkgs-stable.virtualbox;
  };
  users.extraGroups.vboxusers.members = [ "lumi" ];

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      docker
    ];
  };
}
