{ pkgs, lib, ... }:
{
  environment.systemPackages = [ pkgs.helix ];

  home-manager.users.lumi.programs.helix = {
    enable = true;

    defaultEditor = true;

    settings = {
      theme = "boo_berry";

      editor = {
        # LSP stuff
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
          snippets = true;
        };
        auto-completion = true;
        completion-replace = true;
        inline-diagnostics.cursor-line = "hint";

        # Cursor and look
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
        mouse = true; # set this to false to actually learn
        middle-click-paste = false;
        indent-guides.render = true;
        cursorline = false;
        color-modes = true;
        line-number = "relative";
        soft-wrap.enable = true;
        bufferline = "multiple";
        true-color = true;
        whitespace.render = "all";
        insert-final-newline = true;
        trim-trailing-whitespace = true;
        trim-final-newlines = true;

        # File management
        auto-format = true;
        auto-save.after-delay.enable = true;
        file-picker = {
          hidden = false;
        };

        # Misc
        shell = [
          "fish"
          "-c"
        ];
        statusline = {
          center = [ "version-control" ];
        };
      };

      keys.normal = {
        space.space = "file_picker";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        space.l = ":toggle lsp.display-inlay-hints";

        space.n = {
          "n" = ":sh zk new --title";
          "f" = ":sh zk list --interactive";
          "t" = ":sh zk tag list --interactive";
        };
      };
    };

    languages = {
      language = [
        {
          name = "rust";

          # remove ', add <>
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "\"" = "\"";
            "`" = "`";
            "<" = ">";
          };
        }
        {
          name = "markdown";

          roots = [ ".zk" ];
          language-servers = [ "zk" ];
          file-types = [
            "md"
            "markdown"
          ];
        }
      ];

      language-server = {
        zk = {
          command = lib.getExe pkgs.zk;
          args = [ "lsp" ];
        };
      };
    };
  };
}
