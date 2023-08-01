{ inputs, ... } : {
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    #package = inputs.hyprland.packages."x86_64-linux".waybar-hyprland;

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

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Hasklug Nerf Font", "all-the-icons", monospace;
        font-weight: bold;
        font-size: 12px;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces {
        margin-top: 1rem;
        margin: 5px 3px 0px 5px;
      }

      tooltip {
        border: 1px solid;
      }        

      #workspaces button {
        border-radius: 5px;
        padding-left: 6px;
        margin: 5px 0;
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
        /* background: @surface0; */
        margin: 5px 0px 5px 5px;
        padding: 5px 5px 5px 5px;
        border-radius: 5px;
      }

      #tray {
        border-radius: 5px;
      }

      #clock {
        /* color: @lavender; */
      }

      #battery {
        /* color: @green; */
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