{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  home.file = {
    ".doom.d/config.el".source = ../../configs/emacs/config.el;
    ".doom.d/init.el".source = ../../configs/emacs/init.el;
    ".doom.d/packages.el".source = ../../configs/emacs/packages.el;
  };
}
