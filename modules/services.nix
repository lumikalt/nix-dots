{ ... }: {
  services = {
    udiskie = {
      enable = true;
      automount = true;
    };

    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableFishIntegration = true;
    };

    mpris-proxy.enable = true;
  };
}
