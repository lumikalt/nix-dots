{ pkgs, config, lib, ... }: {
  nixpkgs.overlays = let
    myOverlay = self: super: {
      discord = super.discord.override {
        withOpenASAR = true;
        withVencord = true;
        nss = pkgs.nss_3_91;
      };
    };
  in [myOverlay];
}
