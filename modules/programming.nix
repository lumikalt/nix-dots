{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "Lumi Kalt";
    userEmail = "lumi.mia.kalt@gmail.com";

    delta.enable = true;
  };

  # Required for git auth
  programs.gh.enable = true;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        lsp = {
          enable = true;
          display-messages = true;
          display-inline-hints = true;
          snippets = true;
        };
        auto-completion = true;
        auto-format = true;
        mouse = true;
      };
      keys.normal = {
        space.space = "file_picker";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
  };

  services.emacs.enable = true;
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d
  };
}
