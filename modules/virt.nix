{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
  };
  users.extraGroups.vboxusers.members = [ "lumi" ];

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      docker
    ];
  };
}
