{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./nu.nix
    ./shell.nix
  ];

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
