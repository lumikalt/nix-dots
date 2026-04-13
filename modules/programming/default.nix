{ pkgs, ... }:
{
  imports = [
    ./emacs

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
      gnumake
      cmake
      clang-tools

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
      biome

      # Nix
      nil
      statix

      # RISC-V
      ripes

      # Rust
      rust-bin.beta.latest.default

      # Zig
      zig
      zls
    ];
  };
}
