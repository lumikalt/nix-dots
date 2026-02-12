{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.emacs-pgtk ];

  home-manager.users.lumi = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };

    home.file = {
      ".doom.d/config.el".source = ./config.el;
      ".doom.d/init.el".source = ./init.el;
      ".doom.d/packages.el".source = ./packages.el;
    };

    home.packages = with pkgs; [
      nerd-fonts.symbols-only
    ];
  };
}

## For Doom:
# git clone https://github.com/doomemacs/doomemacs ~/.config/emacs
# ~/.config/emacs/bin/doom install
# ~/.config/emacs/bin/doom env
