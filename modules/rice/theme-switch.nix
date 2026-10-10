# Switch Kitty and Waybar between light (stylix scheme) and dark (Catppuccin
# Mocha) by time of day. Everything else follows the stylix scheme.
{
  home-manager.users.lumi =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      darkFrom = 21; # dark from this hour...
      darkUntil = 10; # ...until this hour

      light = config.lib.stylix.colors.withHashtag;
      dark = {
        base00 = "#1e1e2e";
        base01 = "#181825";
        base02 = "#313244";
        base03 = "#45475a";
        base04 = "#585b70";
        base05 = "#cdd6f4";
        base06 = "#f5e0dc";
        base07 = "#b4befe";
        base08 = "#f38ba8";
        base09 = "#fab387";
        base0A = "#f9e2af";
        base0B = "#a6e3a1";
        base0C = "#94e2d5";
        base0D = "#89b4fa";
        base0E = "#cba6f7";
        base0F = "#f2cdcd";
      };

      kittyTheme =
        c:
        pkgs.writeText "kitty-theme.conf" ''
          foreground ${c.base05}
          background ${c.base00}
          selection_foreground ${c.base00}
          selection_background ${c.base05}
          cursor ${c.base05}
          cursor_text_color ${c.base00}
          url_color ${c.base0D}
          active_border_color ${c.base03}
          inactive_border_color ${c.base01}
          color0 ${c.base00}
          color1 ${c.base08}
          color2 ${c.base0B}
          color3 ${c.base0A}
          color4 ${c.base0D}
          color5 ${c.base0E}
          color6 ${c.base0C}
          color7 ${c.base05}
          color8 ${c.base03}
          color9 ${c.base08}
          color10 ${c.base0B}
          color11 ${c.base0A}
          color12 ${c.base0D}
          color13 ${c.base0E}
          color14 ${c.base0C}
          color15 ${c.base07}
        '';

      waybarTheme =
        c:
        pkgs.writeText "waybar-colors.css" (
          lib.concatMapStrings (n: "@define-color ${n} ${c.${n}};\n") (builtins.attrNames dark)
        );

      themes = pkgs.linkFarm "theme-switch" {
        "kitty-light.conf" = kittyTheme light;
        "kitty-dark.conf" = kittyTheme dark;
        "waybar-light.css" = waybarTheme light;
        "waybar-dark.css" = waybarTheme dark;
      };

      kittyCurrent = "${config.xdg.configHome}/kitty/current-theme.conf";
      waybarCurrent = "${config.xdg.configHome}/waybar/colors.css";

      themeSwitch = pkgs.writeShellScript "theme-switch" ''
        mode=''${1:-auto}
        if [ "$mode" = auto ]; then
          hour=$(${pkgs.coreutils}/bin/date +%-H)
          if [ "$hour" -ge ${toString darkFrom} ] || [ "$hour" -lt ${toString darkUntil} ]; then
            mode=dark
          else
            mode=light
          fi
        fi

        ${pkgs.coreutils}/bin/mkdir -p "$(dirname ${kittyCurrent})" "$(dirname ${waybarCurrent})"
        ${pkgs.coreutils}/bin/ln -sf ${themes}/kitty-$mode.conf ${kittyCurrent}
        ${pkgs.coreutils}/bin/ln -sf ${themes}/waybar-$mode.css ${waybarCurrent}

        # Kitty reloads its config on SIGUSR1; waybar reloads style on SIGUSR2.
        ${pkgs.procps}/bin/pkill -USR1 -x 'kitty|\.kitty-wrapped' || true
        ${pkgs.systemd}/bin/systemctl --user --no-block try-reload-or-restart waybar.service || true
      '';
    in
    {
      programs.kitty.extraConfig = lib.mkAfter ''
        include ${kittyCurrent}
      '';

      programs.waybar.style = lib.mkAfter ''
        @import url("file://${waybarCurrent}");
      '';

      systemd.user.services.theme-switch = {
        Unit = {
          Description = "Apply light/dark theme to Kitty and Waybar";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${themeSwitch}";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      # Have the right colors in place before waybar starts.
      systemd.user.services.waybar.Unit = {
        Wants = [ "theme-switch.service" ];
        After = [ "theme-switch.service" ];
      };

      systemd.user.timers.theme-switch = {
        Unit.Description = "Switch light/dark theme by time of day";
        Timer.OnCalendar = [
          "*-*-* ${toString darkUntil}:00:00"
          "*-*-* ${toString darkFrom}:00:00"
        ];
        Install.WantedBy = [ "timers.target" ];
      };

      home.packages = [
        (pkgs.writeShellScriptBin "theme" ''
          exec ${themeSwitch} "$@" # theme [light|dark|auto]
        '')
      ];
    };
}
