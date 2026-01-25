{ pkgs, ... }:
{
  imports = [
    ./helix.nix
  ];

  home-manager.users.lumi.home.packages = with pkgs; [
    tree-sitter

    # LaTeX
    tetex
    texlab

    # Nix
    nil
    statix

    # RISC-V
    ripes
  ];
}
