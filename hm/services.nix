{ ... }: {
  services = {
    udiskie = {
      enable = true;
      automount = true;
    };

    gpg-agent = {
      enable = true;
      # pinentryFlavor = "qt";
      enableFishIntegration = true;
    };

    mpris-proxy.enable = true;
  };
}
