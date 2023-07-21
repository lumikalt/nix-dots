{ inputs, ... } : {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    # package = inputs.hyprland.packages."x86_64-linux".waybar-hyprland;

    settings = [{
      layer = "top";
      position = "left";
      exclusive = true;
      passtrough = false;
      gtk-layer-shell = true;

      height = 0;

      modules-left = [
        "wlr/workspaces"
      ];
      modules-center = [];
      modules-right = [
        "tray"
        "clock"
        "battery"
      ];

      "wlr/workspces" = {
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          default = "";
		      active = "";
        };
      };

	    battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}";
        format-charging = "󰂄";
        format-plugged = "󰂄";
        format-icons = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
        ];
        tooltip = true;
        tooltip-format = "{capacity}%\nDrawing {power}";
      };

      tray = {
        icon-size = 25;
        spacing = 10;
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%d\n%m\n%Y}";
        format = "{:%H\n%M}";
      };
    }];
  };
}