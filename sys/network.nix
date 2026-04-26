{
  networking = {
    hostName = "wumi";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };

    # blocks stuff
    stevenblack = {
      enable = true;
      block = [
        "fakenews"
        # "gambling"
        "porn"
      ];
      whitelist = [
        "gelbooru.com"
      ];
    };

    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
