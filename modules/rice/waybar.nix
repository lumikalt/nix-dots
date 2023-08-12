{ inputs, ... } : {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    package = inputs.hyprland.packages."x86_64-linux".waybar-hyprland;

    settings = [{
      layer = "top";
      position = "left";
      exclusive = true;
      passtrough = false;
      gtk-layer-shell = true;

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
          warning = 20;
          critical = 10;
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
        tooltip-format = "{capacity}%\nDrawing {power}W";
      };

      tray = {
        icon-size = 20;
        spacing = 10;
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%d\n%m\n%y}";
        format = "{:%H\n%M}";
      };
    }];

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-weight: bold;
        font-size: 12px;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces {
        margin: 3px;
      }

      tooltip {
        border: 1px solid;
      }

      #workspaces button {
        margin-bottom: 5px;
        border-radius: 5px;
        transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
        background-color: transparent;
      }

      #workspaces button.active {
        border-radius: 5px;
      }

      #workspaces button.focused {
        border-radius: 5px;
      }

      #workspaces button.urgent {
        color: #ff0000;
        border-radius: 5px;
      }

      #tray,
      #clock,
      #battery {
        margin: 3px;
        border-radius: 5px;
      }

      #tray {
        border-radius: 5px;
      }

      #clock {
        /* color: @lavender; */
      }

      #battery {
        font-size: 16px;
      }

      #battery.charging {
        /* color: @green; */
      }

      #battery.warning:not(.charging) {
        color: #ff0000;
      }
    '';
  };
}