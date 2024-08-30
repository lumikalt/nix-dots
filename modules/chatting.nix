{ pkgs, ... }: {
  home.packages = with pkgs; [
    # (discord.override {
    #   withOpenASAR = true;
    #   withVencord = true;
    #   nss = pkgs.nss_latest;
    # })

    vesktop

    revolt-desktop

    signal-desktop
  ];
}
