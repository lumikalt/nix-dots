{ pkgs, ... }: {
  imports = [
    ./emacs
    
    ./git.nix
    ./helix.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    tree-sitter

    # LaTeX
    tetex texlab

    # Nix
    nil statix
  ];
}
