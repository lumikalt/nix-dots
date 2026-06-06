{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./nu.nix
    ./shell.nix
  ];

  programs.direnv.enable = true;

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      jq
      fzf
      btop
      grc
      feh
      scooter
    ];
  };
}
