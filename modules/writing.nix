{
  home-manager.users.lumi = {
    programs.zk = {
      enable = true;
      settings = {
        note = {
          language = "en";
          default-title = "Untitled";
          filename = "{{id}}-{{slug title}}";
          extension = "md";
          template = "default.md";
          id-charset = "hex";
          id-length = 8;
          id-case = "lower";
        };

        extra = {
          author = "10032";
        };

        format = {
          markdown = {
            linkify-title = true;
            hashtags = true;
            colon-tags = true;
          };
        };
      };
    };

    home.file = {
      # default note template
      ".config/zk/templates/default.md".text = ''
        # {{title}}

        Created: {{format-date now}}
        Tags:

        ---


      '';
    };
  };
}
