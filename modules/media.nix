{ pkgs, inputs, ... }: {
  programs.ncmpcpp.enable = true;

  programs.mpv.enable = true;

  programs.spicetify =
  let 
    sPkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  in {
    enable = true;

    theme = sPkgs.themes.Nord;
  };
}