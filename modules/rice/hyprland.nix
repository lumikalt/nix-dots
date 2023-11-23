{ pkgs, lib, inputs, wallpaper, ... }:
let
  wall = /. + wallpaper;
in {
  # xdg.configFile."hypr/hyprpaper.conf".text = ''
  #   ipc = off
  #   preload = ${wall}
  #   wallpaper = eDP-1,${wall}
  # '';

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast 
    pkgs.mpvpaper
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = true;

    extraConfig = ''
      monitor = ,preferred,auto,1

      # exec-once = hyprpaper &
      exec-once = mpvpaper '*' ${wall} -o "--loop=yes"
      
      exec-once = systemctl --user import-environment
      exec-once = nm-applet &
      exec-once = blueman-applet &
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

      # use this instead of hidpi patches
      xwayland {
        force_zero_scaling = true
      }

      input {
        kb_file =
        kb_layout = pt
        kb_variant =
        kb_model =
        kb_options = compose:caps
        kb_rules =

        follow_mouse = 1

        touchpad {
          natural_scroll = yes
          disable_while_typing = no

          scroll_factor = 0.7
        }
      }

      misc {
        vfr = on
        disable_hyprland_logo = true
        animate_manual_resizes = true
        focus_on_activate = true
        disable_autoreload = true
      }

      general {
        gaps_in = 2
        gaps_out = 5
        border_size = 2
        apply_sens_to_raw = 0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      }

      decoration {
        rounding = 5
        dim_inactive = true

        blur {
          size = 2 # minimum 1
          passes = 2 # minimum 1
        }
        
        drop_shadow = true
        shadow_range = 100
        shadow_render_power = 5
      }

      animations {
        enabled = 1
        bezier = overshot,0.13,0.99,0.29,1.1
        animation = windows,1,4,overshot,slide
        animation = border,1,10,default
        animation = fade,1,10,default
        animation = workspaces,1,6,overshot,slidevert
      }

      dwindle {
        pseudotile = 0 # enable pseudotiling on dwindle
        force_split = 0
      }

      gestures {
        workspace_swipe = yes
        workspace_swipe_fingers = 4
        workspace_swipe_forever = yes
	      workspace_swipe_cancel_ratio = 0.15
      }

      # Window Rules
      windowrule = workspace 1, ^(kitty)$
      windowrule = workspace 1, ^(code)$
      windowrule = workspace 2, ^(firefox)$
      windowrule = float, ^(thunar)$
      windowrulev2 = workspace 3, title:^(.*(Disc|WebC)ord.*)$
      # fix xwayland apps
      windowrulev2 = rounding 0, xwayland:1, floating:1

      # Basics
      bind = SUPER,q, killactive
      bind = SUPER,m, exit
      bind = SUPER,s, togglefloating
      bind = SUPER,f, fullscreen
      bind = SUPER,d, exec,bemenu-run -p "run: "
      bind = SUPER,p, pseudo,
      bind =      ,Print, exec, grimblast --notify copy area
      bind = SHIFT,Print, exec, grimblast --notify copysave area
      bind = SUPER,x, exec,pkill waybar && waybar &

      # Terminal
      bind = SUPER,RETURN, exec,kitty

      # Personal apps
      bind = SUPER,w, exec,firefox
      bind = SUPER,a, exec,code

      # Utility
      bind = SUPER,c, exec,hyprpicker -ar && notify-send -u critical -t 4000 "$(wl-paste)"
      bind = SUPER,l, exec,swaylock

      # Movement & Workspaces
      bindm = SUPER,mouse:272, movewindow
      bindm = SUPER,mouse:273, resizewindow

      bind = SUPER,left,  movefocus,l
      bind = SUPER,right, movefocus,r
      bind = SUPER,up,    movefocus,u
      bind = SUPER,down,  movefocus,d

      ${builtins.concatStringsSep "" (builtins.genList (
        x: let
          ws = toString (x + 1);
        in ''
          bind = SUPER,${ws}, workspace,${ws}
          bind = ALT,  ${ws}, movetoworkspace,${ws}
        ''
      ) 9)}

      bind = SUPER,mouse_down, workspace,e+1
      bind = SUPER,mouse_up,   workspace,e-1

      bind = SUPER,      g,   togglegroup
      bind = SUPER,      tab, changegroupactive,f
      bind = SUPER_SHIFT,tab, changegroupactive,b

      # will switch to a submap called resize
      bind = ALT,R, submap,resize

      # will start a submap called "resize"
      submap = resize
        # sets repeatable binds for resizing the active window
        binde = ,right, resizeactive, 10   0
        binde = ,left,  resizeactive,-10   0
        binde = ,up,    resizeactive,  0 -10
        binde = ,down,  resizeactive,  0  10

        # use reset to go back to the global submap
        bind = ,escape,submap,reset
      # will reset the submap, meaning end the current one and return to the global one
      submap = reset

      # Audio
      bind = ,XF86AudioPlay,  exec,playerctl play-pause
      bind = ,XF86AudioMedia, exec,playerctl play-pause
      bind = ,XF86AudioPrev,  exec,playerctl previous
      bind = ,XF86AudioNext,  exec,playerctl next
      bind = ,XF86AudioStop,  exec,playerctl stop
      bind = ,XF86MonBrightnessUp,   exec,brightnessctl set +10%
      bind = ,XF86MonBrightnessDown, exec,brightnessctl set 10%-
    '';
  };

  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["graphical-session.target"];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    
    settings = {
      effect-blur = "20x3";
      fade-in = 0.5;
    };
  };
}
