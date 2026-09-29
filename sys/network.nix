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

    # This kernel doesn't build the legacy xtables modules, so nftables is
    # required (also makes the waydroid module pick pkgs.waydroid-nftables).
    nftables.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
