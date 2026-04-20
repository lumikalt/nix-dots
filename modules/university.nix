{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages =
      with pkgs;
      with pkgs.linphonePackages;
      [
        gns3-gui
        linphone-desktop
      ];
  };
}
