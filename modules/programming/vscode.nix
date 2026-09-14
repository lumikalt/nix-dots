{ pkgs, ... }:
{
  home-manager.users.lumi =
    { lib, config, ... }:
    {
      programs.vscode = {
        enable = true;

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            rust-lang.rust-analyzer
          ];

          # userSettings/enableUpdateCheck/enableExtensionUpdateCheck are intentionally
          # unset here: setting them makes home-manager symlink settings.json straight
          # into the read-only /nix/store, which breaks VSCode's own "Save" in the
          # Settings UI. Instead we seed a real, writable file below via activation.
        };
      };

      home.activation.vscodeSettings =
        let
          settings = (pkgs.formats.json { }).generate "vscode-user-settings.json" {
            "files.autoSave" = "afterDelay";
            "files.autoSaveDelay" = 2000;

            "editor.fontLigatures" = true;

            "update.mode" = "none";
            "extensions.autoCheckUpdates" = false;
          };
          target = "${config.xdg.configHome}/Code/User/settings.json";
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          target=${lib.escapeShellArg target}
          if [ ! -e "$target" ] || [ -L "$target" ]; then
            run mkdir -p "$(dirname "$target")"
            run rm -f "$target"
            run install -m644 ${settings} "$target"
          fi
        '';
    };
}
