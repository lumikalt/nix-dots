{ pkgs, ... }:
{
  home-manager.users.lumi =
    { lib, ... }:
    let
      writerTypes = [
        # Word formats
        "application/msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template"

        # OpenDocument
        "application/vnd.oasis.opendocument.text"
        "application/vnd.oasis.opendocument.text-template"

        # Other text formats
        "application/rtf"
        "text/rtf"
        "text/plain"
      ];

      calcTypes = [
        # Excel formats
        "application/vnd.ms-excel"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.template"

        # OpenDocument
        "application/vnd.oasis.opendocument.spreadsheet"
        "application/vnd.oasis.opendocument.spreadsheet-template"

        # Data tables
        "text/csv"
        "text/tab-separated-values"
      ];

      impressTypes = [
        # PowerPoint formats
        "application/vnd.ms-powerpoint"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        "application/vnd.openxmlformats-officedocument.presentationml.template"
        "application/vnd.openxmlformats-officedocument.presentationml.slideshow"

        # OpenDocument
        "application/vnd.oasis.opendocument.presentation"
        "application/vnd.oasis.opendocument.presentation-template"
      ];

      drawTypes = [
        # Drawing formats
        "application/vnd.oasis.opendocument.graphics"
        "application/vnd.oasis.opendocument.graphics-template"
      ];

      lo = app: _: [ "libreoffice-${app}.desktop" ];

    in
    {
      xdg.mimeApps = {
        enable = true;

        defaultApplications =
          lib.genAttrs writerTypes (lo "writer")
          // lib.genAttrs calcTypes (lo "calc")
          // lib.genAttrs impressTypes (lo "impress")
          // lib.genAttrs drawTypes (lo "draw");
      };

      home.packages = with pkgs; [
        libreoffice
        xournalpp
        rnote

        (aspellWithDicts (
          dicts: with dicts; [
            en
            en-science
            en-computers
            pt_PT
          ]
        ))
        hunspell
        hunspellDicts.en-us-large
        hunspellDicts.pt-pt
        hunspellDicts.tok
        libspelling

        ltspice
      ];
    };
}
