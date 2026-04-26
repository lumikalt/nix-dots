{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages =
      with pkgs;
      with pkgs.linphonePackages;
      [
        gns3-gui
        gns3-server
        linphone-desktop
        asterisk-stable
      ];
  };
}
