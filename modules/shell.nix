{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting.
    '';

    shellAliases = {
      
    };
  };

  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;
  };

  programs.exa = {
    enable = true;

    enableAliases = true;
    git = true;
    icons = true;
  };
}
