{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk
  };

  home.file = {
    ".doom.d/config.el".source = ./config.el;
    ".doom.d/init.el".source = ./init.el;
    ".doom.d/packages.el".source = ./packages.el;
  };
}