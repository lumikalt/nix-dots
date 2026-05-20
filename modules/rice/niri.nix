{
  pkgs,
  wallpaper,
  ...
}:
let
  enable = true;
in
{
  programs.niri = {
    enable = enable;
    package = pkgs.niri-unstable;
  };
  niri-flake.cache.enable = true;

  home-manager.users.lumi =
    { config, lib, ... }:
    lib.mkIf enable {
      programs.niri =
        with config.lib.niri.actions;
        let
          loginctl = "${pkgs.systemd}/bin/loginctl";
          playerctl = lib.getExe pkgs.playerctl;
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
          brightnessctl = lib.getExe pkgs.brightnessctl;
        in
        {
          settings = {
            screenshot-path = null;

            environment = {
              NIXOS_OZONE_WL = "1"; # support electron and chromium based apps
              # DISPLAY = ":0"; # important for xwayland-satellite
              QT_QPA_PLATFORM = "wayland"; # optional: force QT apps to always use wayland
            };

            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

            spawn-at-startup = [
              # { command = [ "xwayland-satellite" ]; }
              {
                argv = [
                  "swaybg"
                  "--image"
                  "${wallpaper}"
                ];
              }
            ];

            clipboard = {
              disable-primary = true;
            };

            hotkey-overlay.skip-at-startup = true;

            input = {
              touchpad.enable = false;

              focus-follows-mouse.enable = true;
              focus-follows-mouse.max-scroll-amount = "50%";

              keyboard = {
                xkb = {
                  layout = "pt";
                  options = "compose:caps";
                };
              };

              tablet = {
                # map-to-output = "eDP-1";
              };
            };

            outputs = {
              "DVI-I-1" = {
                scale = 1.0;
              };
            };

            layout = {
              always-center-single-column = true;
              gaps = 5;
              border.width = 2;
            };

            binds = {
              # movement
              "Mod+Ctrl+Left".action = move-column-left;
              "Mod+Ctrl+Right".action = move-column-right;

              "Mod+F".action = maximize-column;
              "Mod+Shift+F".action = fullscreen-window;

              "Mod+Q".action = close-window;
              "Mod+Shift+Q".action = quit;
            }
            // lib.listToAttrs (
              lib.concatMap (n: [
                {
                  name = "Mod+${toString n}";
                  value.action = focus-workspace n;
                }
                {
                  name = "Mod+Shift+${toString n}";
                  value.action = move-column-to-index n;
                }
              ]) (lib.range 1 9)
            )
            // {
              # programs
              "Mod+Return".action.spawn = "kitty";
              "Mod+W".action.spawn = "firefox";

              "Mod+D".action.spawn = [
                "bemenu-run"
                "-p"
                "run: "
              ];

              # media
              "Print".action.screenshot = [ ];
              "Mod+Print".action.screenshot-screen = {
                show-pointer = false;
              };

              "Mod+C".action.spawn-sh = ''
                ${lib.getExe pkgs.hyprpicker} -ar &&
                ${pkgs.libnotify}/bin/notify-send -t 4000
                  (${pkgs.wl-clipboard}/bin/wl-paste)
              '';
            }
            // lib.genAttrs [ "Super_L" "Mod+L" ] (_: {
              action.spawn = [
                loginctl
                "lock-session"
              ];
            })
            // {
              "XF86AudioPlay".action.spawn = [
                playerctl
                "play-pause"
              ];
              "XF86AudioMedia".action.spawn = [
                playerctl
                "play-pause"
              ];
              "XF86AudioPrev".action.spawn = [
                playerctl
                "previous"
              ];
              "XF86AudioNext".action.spawn = [
                playerctl
                "next"
              ];
              "XF86AudioStop".action.spawn = [
                playerctl
                "stop"
              ];
              "XF86AudioRaiseVolume".action.spawn = [
                wpctl
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "5%+"
              ];
              "XF86AudioLowerVolume".action.spawn = [
                wpctl
                "set-volume"
                "@DEFAULT_AUDIO_SINK@"
                "5%-"
              ];
              "XF86MonBrightnessUp".action.spawn = [
                brightnessctl
                "set"
                "+10%"
              ];
              "XF86MonBrightnessDown".action.spawn = [
                brightnessctl
                "set"
                "10%-"
              ];
            };
          };
        };
    };
}

# { center-column = «thunk»; center-visible-columns = «thunk»; center-window = «thunk»; clear-dynamic-cast-target = «thunk»; close-overview = «thunk»; close-window = «thunk»; consume-or-expel-window-left = «thunk»; consume-or-expel-window-right = «thunk»; consume-window-into-column = «thunk»; debug-toggle-damage = «thunk»; debug-toggle-opaque-regions = «thunk»; do-screen-transition = «thunk»; expand-column-to-available-width = «thunk»; expel-window-from-column = «thunk»; focus-column = «thunk»; focus-column-first = «thunk»; focus-column-last = «thunk»; focus-column-left = «thunk»; focus-column-left-or-last = «thunk»; focus-column-or-monitor-left = «thunk»; focus-column-or-monitor-right = «thunk»; focus-column-right = «thunk»; focus-column-right-or-first = «thunk»; focus-floating = «thunk»; focus-monitor = «thunk»; focus-monitor-down = «thunk»; focus-monitor-left = «thunk»; focus-monitor-next = «thunk»; focus-monitor-previous = «thunk»; focus-monitor-right = «thunk»; focus-monitor-up = «thunk»; focus-tiling = «thunk»; focus-window-bottom = «thunk»; focus-window-down = «thunk»; focus-window-down-or-column-left = «thunk»; focus-window-down-or-column-right = «thunk»; focus-window-down-or-top = «thunk»; focus-window-in-column = «thunk»; focus-window-or-monitor-down = «thunk»; focus-window-or-monitor-up = «thunk»; focus-window-or-workspace-down = «thunk»; focus-window-or-workspace-up = «thunk»; focus-window-previous = «thunk»; focus-window-top = «thunk»; focus-window-up = «thunk»; focus-window-up-or-bottom = «thunk»; focus-window-up-or-column-left = «thunk»; focus-window-up-or-column-right = «thunk»; focus-workspace = «thunk»; focus-workspace-down = «thunk»; focus-workspace-previous = «thunk»; focus-workspace-up = «thunk»; fullscreen-window = «thunk»; maximize-column = «thunk»; maximize-window-to-edges = «thunk»; move-column-left = «thunk»; move-column-left-or-to-monitor-left = «thunk»; move-column-right = «thunk»; move-column-right-or-to-monitor-right = «thunk»; move-column-to-first = «thunk»; move-column-to-index = «thunk»; move-column-to-last = «thunk»; move-column-to-monitor = «thunk»; move-column-to-monitor-down = «thunk»; move-column-to-monitor-left = «thunk»; move-column-to-monitor-next = «thunk»; move-column-to-monitor-previous = «thunk»; move-column-to-monitor-right = «thunk»; move-column-to-monitor-up = «thunk»; move-column-to-workspace-down = «thunk»; move-column-to-workspace-up = «thunk»; move-window-down = «thunk»; move-window-down-or-to-workspace-down = «thunk»; move-window-to-floating = «thunk»; move-window-to-monitor = «thunk»; move-window-to-monitor-down = «thunk»; move-window-to-monitor-left = «thunk»; move-window-to-monitor-next = «thunk»; move-window-to-monitor-previous = «thunk»; move-window-to-monitor-right = «thunk»; move-window-to-monitor-up = «thunk»; move-window-to-tiling = «thunk»; move-window-to-workspace-down = «thunk»; move-window-to-workspace-up = «thunk»; move-window-up = «thunk»; move-window-up-or-to-workspace-up = «thunk»; move-workspace-down = «thunk»; move-workspace-to-index = «thunk»; move-workspace-to-monitor = «thunk»; move-workspace-to-monitor-down = «thunk»; move-workspace-to-monitor-left = «thunk»; move-workspace-to-monitor-next = «thunk»; move-workspace-to-monitor-previous = «thunk»; move-workspace-to-monitor-right = «thunk»; move-workspace-to-monitor-up = «thunk»; move-workspace-up = «thunk»; open-overview = «thunk»; power-off-monitors = «thunk»; power-on-monitors = «thunk»; quit = «thunk»; reset-window-height = «thunk»; set-column-display = «thunk»; set-column-width = «thunk»; set-dynamic-cast-monitor = «thunk»; set-dynamic-cast-window = «thunk»; set-window-height = «thunk»; set-window-width = «thunk»; set-workspace-name = «thunk»; show-hotkey-overlay = «thunk»; spawn = «thunk»; spawn-sh = «thunk»; suspend = «thunk»; swap-window-left = «thunk»; swap-window-right = «thunk»; switch-focus-between-floating-and-tiling = «thunk»; switch-layout = «thunk»; switch-preset-column-width = «thunk»; switch-preset-column-width-back = «thunk»; switch-preset-window-height = «thunk»; switch-preset-window-height-back = «thunk»; switch-preset-window-width = «thunk»; switch-preset-window-width-back = «thunk»; toggle-column-tabbed-display = «thunk»; toggle-debug-tint = «thunk»; toggle-keyboard-shortcuts-inhibit = «thunk»; toggle-overview = «thunk»; toggle-window-floating = «thunk»; toggle-window-rule-opacity = «thunk»; toggle-windowed-fullscreen = «thunk»; unset-workspace-name = «thunk»; }
