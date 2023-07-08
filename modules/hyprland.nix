{ ... }: {
  home-manager.sharedModules = [
    {
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        ipc = off
        preload = ~/flakes/assets/wallpapers/wallpaper.png
        wallpaper = eDP-1,~/flakes/assets/wallpapers/wallpaper.png
      '';
    }
    {
      xdg.configFile."hypr/hyprland.conf".text = ''
        monitor=,preferred,auto,1

        exec-once=hyprpaper &

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
        }

        general {
            sensitivity=1.0 # for mouse cursor
            # main_mod=SUPER

            gaps_in=2
            gaps_out=5
            border_size=2
            col.active_border=0xfff5c2e7
            col.inactive_border=0xff45475a
            apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)

            col.group_border=0xff89dceb
            col.group_border_active=0xfff9e2af


            # damage_tracking=full # leave it on full unless you hate your GPU and want to make it suffer
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
            col.shadow=0x33000000
            col.shadow_inactive=0x22000000
        }

        animations {
            enabled=1
            # bezier=overshot,0.05,0.9,0.1,1.1
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
        }


        # Window Rules
        windowrule=workspace 1,^(kitty)$
        windowrule=workspace 1,^(code)$
        windowrule=workspace 2,^(firefox)$
        windowrule=workspace 3,^(discord)$
        windowrule=workspace 3,^(rolt-desktop)$
        windowrule=float,^(thunar)$


        # Basics
        bind=SUPER,Q,killactive
        bind=SUPER,M,exit
        bind=SUPER,S,togglefloating
        bind=SUPER,F,fullscreen
        bind=SUPER,D,exec,bemenu-run -p "run: "
        bind=SUPER,P,pseudo,
        bind=,Print,exec,grim -g "$(slurp)" - | wl-copy -t image/png
        bind=SUPER,z,exec,waybar &
        bind=SUPER,x,exec,pkill waybar

        # Terminal
        bind=SUPER,RETURN,exec,kitty

        # Personal apps
        bind=SUPER,W,exec,firefox --enable-features=UseOzonePlatform --ozone-platform=wayland
        bind=SUPER,A,exec,code --enable-features=UseOzonePlatform --ozone-platform=wayland

        # Utility
        bind=SUPER,C,exec,hyprpicker && notify-send -u critical -t 4000 "$(wl-paste)"
        bind=SUPER,L,exec,~/.config/hypr/scripts/lock

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
    }
  ];
}
