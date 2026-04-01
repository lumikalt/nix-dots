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
          id-charset = "alphanum";
          id-length = 8;
          id-case = "lower";
        };

        extra = {
          author = "Lumi #10032";
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

        Created: {{date "2006-01-02"}}
        Tags:

        ---


      '';
    };
  };
}
