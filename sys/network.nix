{ config, pkgs, lib, ... }: {
  networking = {
    hostName = "wumi";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };

    # Ad blocking!!
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" ];
    };

    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
