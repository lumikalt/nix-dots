{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      rust-lang.rust-analyzer
    ];

    userSettings = {
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 2000;

      "editor.fontLigatures" = true;

    };
  };
}
