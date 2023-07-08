{ pkgs, ... }: {
  # imports = [ ./emacs ];

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
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
          snippets = true;
        };
        auto-completion = true;
        auto-format = true;
        completion-replace = true;
        
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
        mouse = true;
        indent-guides.render = true;
        cursorline = false;
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        true-color = true;

        shell = [ "fish" "-c" ];

        statusline = {
          center = [ "version-control" ];
        };
      };
      keys.normal = {
        space.space = "file_picker";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
  };
}
