{ lib, pkgs, ... }:
{
  users.users.lumi.shell = pkgs.fish;
  programs.fish.enable = true;
  environment.systemPackages = [ pkgs.fish ];

  home-manager.users.lumi = {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set -p PATH $HOME/.config/emacs/bin
        fish_vi_key_bindings
      '';

      plugins =
        let
          names = [
            "puffer" # ... -> ../..
            "grc" # colorize ll, etc.
            "done" # notification with exit status
            "colored-man-pages" # self-explanatory
            "autopair" # self-explanatory
            "fish-you-should-use" # reminder for aliases
          ];
        in
        map (name: {
          inherit name;
          src = pkgs.fishPlugins.${name}.src;
        }) names;

      shellAliases = {
        tarnow = "tar -acf";
        untar = "tar -xvf";
        mkd = "mkdir -pv";
        jctl = "journalctl -p 3 -xb";
        icat = "kitty +kitten icat";
      };

      shellAbbrs = {
        genpass = "${lib.getExe pkgs.pwgen} -c -n -y -s 32 | head";
      };

      functions = {
        # Search in browser
        ddg = ''
          if count $argv > /dev/null
            ${lib.getExe pkgs.w3m} +15 "https://lite.duckduckgo.com/lite?kd=-1&q=$argv"
          else
            ${lib.getExe pkgs.w3m} "https://lite.duckduckgo.com/lite?kd=-1"
          end
        '';
        hm = "${lib.getExe pkgs.w3m} https://nix-community.github.io/home-manager/options.xhtml";

        backup = {
          argumentNames = [ "filename" ];
          body = "cp -i $filename $filename.bak";
        };

        mkcd = {
          argumentNames = [ "dir" ];
          body = ''
            mkdir $dir
            cd $dir
          '';
        };

        nix-where = {
          argumentNames = [ "exe" ];
          body = ''
            nix path-info -r $(which $exe)
          '';
        };
      };
    };
    programs.carapace.enableFishIntegration = true;
    programs.eza.enableFishIntegration = true;
    programs.kitty.shellIntegration.enableFishIntegration = true;
  };
}
