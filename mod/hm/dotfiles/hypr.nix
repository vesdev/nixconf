{ pkgs, ... }: {
  home.file.".config/hypr/wallpaper.png".source =
    pkgs.lib.mkDefault ./wallpaper.png;
  home.file.".config/hypr/hyprpaper.conf".text = pkgs.lib.mkDefault # hyprland
    ''
      preload = ~/.config/hypr/wallpaper.png
      #if more than one preload is desired then continue to preload other backgrounds

      wallpaper = ,~/.config/hypr/wallpaper.png
      #wallpaper = monitor2,~/.config/hypr/wallpaper.jpg
      #wallpaper = monitor2,~/.config/hypr/wallpaper.jpg

    '';

  home.file.".config/hypr/hyprland.conf".text = pkgs.lib.mkDefault # hyprlang
    ''
      # TODO: pass monitor config from the host
      monitor=DP-2,2560x1440@170,1080x768,1.25
      monitor=DP-3,1920x1080@144,3128x840,1
      monitor=HDMI-A-1,1920x1080@60,0x0,1,transform,1
      workspace=1,m:DP-2,
      workspace=2,m:DP-3,
      workspace=3,m:HDMI-A-1,

      input {
          kb_layout = de
          kb_variant = us
          kb_model = 
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad:natural_scroll = no

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          gaps_in = 4
          gaps_out = 8
          border_size = 1
          col.active_border = rgba(e4a88aff) rgba(e95378ff) 90deg
          col.inactive_border = rgba(e4a88aff) rgba(00000000) 90deg
          layout = master
          allow_tearing = true
      }

      decoration {
          rounding = 0
          active_opacity = 0.95
          inactive_opacity = 0.8
          drop_shadow = no
          blur:enabled = true
      }

      env = WLR_DRM_NO_ATOMIC,1
      windowrulev2 = immediate, xwayland:1

      animations:enabled = no
      master:new_is_master = false
      xwayland:force_zero_scaling = true

      $mod = SUPER

      bind = $mod, s, exec, grim -g "$(slurp -d)" - | wl-copy
      bind = $mod, Return, exec, kitty
      bind = $mod, B, exec, librewolf
      bind = $mod, Space, exec, rofi -combi-modi drun,run,ssh -theme squared-material-red -show combi -icon-theme Papirus -show-icons

      bind = $mod, Q, killactive, 
      bind = $mod SHIFT, X, exit, 
      bind = $mod SHIFT, f, fullscreen, 
      bind = $mod CONTROL, f, fakefullscreen, 
      bind = $mod, f, fullscreen, 1 
      bind = $mod, t, togglefloating  
      bind = $mod, d, toggleopaque  

      # Move focus with mainMod + arrow keys
      bind = $mod, h, movefocus, l
      bind = $mod, l, movefocus, r
      bind = $mod, k, movefocus, u
      bind = $mod, j, movefocus, d

      bind = $mod CONTROL, l, resizeactive, 100 0
      bind = $mod CONTROL, h, resizeactive, -100 0
      bind = $mod CONTROl, k, resizeactive, 0 -100
      bind = $mod CONTROL, j, resizeactive, 0 100

      bind = $mod, BACKSLASH, layoutmsg, swapwithmaster master

      bind = $mod ALT, l, layoutmsg, orientationright
      bind = $mod ALT, h, layoutmsg, orientationleft
      bind = $mod ALT, k, layoutmsg, orientationtop
      bind = $mod ALT, j, layoutmsg, orientationbottom

      # Switch workspaces with mainMod + [0-9]
      bind = $mod, 1, moveworkspacetomonitor, 1 current
      bind = $mod, 2, moveworkspacetomonitor, 2 current
      bind = $mod, 3, moveworkspacetomonitor, 3 current
      bind = $mod, 4, moveworkspacetomonitor, 4 current
      bind = $mod, 5, moveworkspacetomonitor, 5 current
      bind = $mod, 6, moveworkspacetomonitor, 6 current
      bind = $mod, 7, moveworkspacetomonitor, 7 current
      bind = $mod, 8, moveworkspacetomonitor, 8 current
      bind = $mod, 9, moveworkspacetomonitor, 9 current

      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mod SHIFT, 9, movetoworkspacesilent, 9

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      exec-once=hyprpaper
      exec-once=waybar
      exec=otd-daemon
    '';
}
