{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nushell ];

  home-manager.users.lumi = {
    programs.nushell = {
      enable = true;
    };

    programs.carapace.enableNushellIntegration = true;
    programs.eza.enableNushellIntegration = false; # breaks ls behaviour
  };
}
