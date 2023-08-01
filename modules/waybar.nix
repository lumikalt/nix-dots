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
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces {
        border-radius: 1rem;
        background-color: @surface0;
        margin-top: 1rem;
        margin: 7px 3px 0px 7px;
      }

      tooltip {
        background: @base;
        border: 1px solid @pink;
      }

      tooltip label {
        color: @text;
      }

      #workspaces button {
        color: @pink;
        border-radius: 1rem;
        padding-left: 6px;
        margin: 5px 0;
        box-shadow: inset 0 -3px transparent;
        transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
        background-color: transparent;
      }

      #workspaces button.active {
        color: @flamingo;
        border-radius: 1rem;
        background-color: @surface1;
      }

      #workspaces button.focused {
        color: @rosewater;
        border-radius: 1rem;
        background-color: @surface1;
      }

      #workspaces button.urgent {
        color: @red;
        border-radius: 1rem;
      }

      #tray,
      #clock,
      #battery {
        background: @surface0;
        margin: 5px 0px 5px 5px;
        padding: 10px 5px 10px 5px;
        border-radius: 1rem;
      }

      #tray {
        border-radius: 1rem;
      }

      #clock {
        color: @lavender;
      }

      #battery {
        color: @green;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }
    '';
  };
}