{ pkgs, ... }:
{
  imports = [
    ./emacs.nix
    ./git.nix
    ./helix.nix
    ./vscode.nix
  ];

  environment.systemPackages = [ pkgs.gcc ];

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      tree-sitter
      vscode-langservers-extracted

      # C
      gcc

      # JavaScript/TypeScript
      astro-language-server
      typescript-language-server

      # Koka
      koka

      # LaTeX
      tetex
      texlab

      # LLVM
      lldb

      # Markdown
      markdown-oxide

      # Nix
      nil
      statix

      # RISC-V
      ripes

      # Rust
      rust-bin.beta.latest.default
    ];
  };
}
