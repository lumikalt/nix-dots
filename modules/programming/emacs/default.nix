{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.emacs-pgtk ];

  home-manager.users.lumi = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };

    home.file = {
      ".doom.d/config.el".source = ./configs/emacs/config.el;
      ".doom.d/init.el".source = ./configs/emacs/init.el;
      ".doom.d/packages.el".source = ./configs/emacs/packages.el;
    };
  };
}
# Run once: ~/.config/emacs/bin/doom env
