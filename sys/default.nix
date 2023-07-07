{ ... }: {
  imports = [
    ./boot.nix
    ./extraHardware.nix
    ./fonts.nix
    ./network.nix
    ./power.nix
    ./security.nix
    ./services.nix
    ./sound.nix
  ];
}