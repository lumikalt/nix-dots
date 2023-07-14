{ pkgs, ... }: {
  nixpkgs.overlays = let
    myOverlay = self: super: {
      discord = super.discord.override {
        withOpenASAR = true;
        withVencord = true;
        nss = pkgs.nss_latest;
      };
    };
  in [myOverlay];
}
