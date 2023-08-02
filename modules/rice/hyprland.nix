{ pkgs, lib, inputs, wallpaper, ... }:
let
  wall = /. + wallpaper;
in {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = ${wall}
    wallpaper = eDP-1,${wall}
  '';

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast 
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemdIntegration = true;

    extraConfig = ''
      monitor=,preferred,auto,1

      exec-once=hyprpaper &

      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

      # use this instead of hidpi patches
      xwayland {
        force_zero_scaling = true
      }

      input {
        kb_file=
        kb_layout=pt
        kb_variant=
        kb_model=
        kb_options= compose:caps
        kb_rules=

        follow_mouse=1

        touchpad {
          natural_scroll=yes
          disable_while_typing=no
        }
      }

      misc {
        vfr=on
        disable_hyprland_logo=true
        animate_manual_resizes=true
        focus_on_activate=true
        disable_autoreload = true
      }

      general {
        sensitivity=1.0 # for mouse cursor
        # main_mod=SUPER

        gaps_in=2
        gaps_out=5
        border_size=2
        apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      }

      decoration {
        rounding=5
        multisample_edges=true
        dim_inactive=true

        blur=2
        blur_size=2 # minimum 1
        blur_passes=2 # minimum 1
        blur_new_optimizations=1

        drop_shadow=true
        shadow_range=100
        shadow_render_power=5
      }

      animations {
        enabled=1
        bezier=overshot,0.13,0.99,0.29,1.1
        animation=windows,1,4,overshot,slide
        animation=border,1,10,default
        animation=fade,1,10,default
        animation=workspaces,1,6,overshot,slidevert
      }

      dwindle {
        pseudotile=0 # enable pseudotiling on dwindle
        force_split=0
      }

      gestures {
        workspace_swipe=yes
        workspace_swipe_fingers=4
        workspace_swipe_forever=yes
      }


      # Window Rules
      windowrule=workspace 1,^(kitty)$
      windowrule=workspace 1,^(code)$
      windowrule=workspace 2,^(firefox)$
      windowrulev2 = workspace 3, title:^(.*(Disc|WebC)ord.*)$
      windowrule=float,^(thunar)$

      # fix xwayland apps
      windowrulev2 = rounding 0, xwayland:1, floating:1

      # Basics
      bind=SUPER,Q,killactive
      bind=SUPER,M,exit
      bind=SUPER,S,togglefloating
      bind=SUPER,F,fullscreen
      bind=SUPER,D,exec,bemenu-run -p "run: "
      bind=SUPER,P,pseudo,
      # bind=,Print,exec,grim -g "$(slurp)" - | wl-copy -t image/png
      bind=,Print,exec,grimblast --notify copysave area
      bind=SUPER,z,exec,waybar &
      bind=SUPER,x,exec,pkill waybar

      # Terminal
      bind=SUPER,RETURN,exec,kitty

      # Personal apps
      bind=SUPER,W,exec,firefox --enable-features=UseOzonePlatform --ozone-platform=wayland
      bind=SUPER,A,exec,code

      # Utility
      bind=SUPER,C,exec,hyprpicker -ar && notify-send -u critical -t 4000 "$(wl-paste)"
      bind=SUPER,L,exec,swaylock

      # Movement & Workspaces
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      bind=SUPER,left,movefocus,l
      bind=SUPER,right,movefocus,r
      bind=SUPER,up,movefocus,u
      bind=SUPER,down,movefocus,d

      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,0,workspace,10

      bind=ALT,1,movetoworkspace,1
      bind=ALT,2,movetoworkspace,2
      bind=ALT,3,movetoworkspace,3
      bind=ALT,4,movetoworkspace,4
      bind=ALT,5,movetoworkspace,5
      bind=ALT,6,movetoworkspace,6
      bind=ALT,7,movetoworkspace,7
      bind=ALT,8,movetoworkspace,8
      bind=ALT,9,movetoworkspace,9
      bind=ALT,0,movetoworkspace,10

      bind=ALT,1,movetoworkspacesilent,1
      bind=ALT,2,movetoworkspacesilent,2
      bind=ALT,3,movetoworkspacesilent,3
      bind=ALT,4,movetoworkspacesilent,4
      bind=ALT,5,movetoworkspacesilent,5
      bind=ALT,6,movetoworkspacesilent,6
      bind=ALT,7,movetoworkspacesilent,7
      bind=ALT,8,movetoworkspacesilent,8
      bind=ALT,9,movetoworkspacesilent,9
      bind=ALT,0,movetoworkspacesilent,10

      bind=SUPER,mouse_down,workspace,e+1
      bind=SUPER,mouse_up,workspace,e-1

      bind=SUPER,g,togglegroup
      bind=SUPER,tab,changegroupactive,f
      bind=SUPER_SHIFT,tab,changegroupactive,b

      # will switch to a submap called resize
      bind=ALT,R,submap,resize

      # will start a submap called "resize"
      submap=resize
        # sets repeatable binds for resizing the active window
        binde=,right,resizeactive,10 0
        binde=,left,resizeactive,-10 0
        binde=,up,resizeactive,0 -10
        binde=,down,resizeactive,0 10

        # use reset to go back to the global submap
        bind=,escape,submap,reset
      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # Audio
      bind=,XF86AudioPlay,exec,playerctl play-pause
      bind=,XF86AudioMedia,exec,playerctl play-pause
      bind=,XF86AudioPrev,exec,playerctl previous
      bind=,XF86AudioNext,exec,playerctl next
      bind=,XF86AudioStop,exec,playerctl stop
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
