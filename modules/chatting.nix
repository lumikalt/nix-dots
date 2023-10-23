{ pkgs, ... }: {
  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
      nss = pkgs.nss_latest;
    })

    revolt-desktop

    signal-desktop
  ];
}
