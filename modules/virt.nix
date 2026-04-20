{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "lumi" ];

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      docker
      # dockerTools
    ];
  };
}
