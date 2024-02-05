{ pkgs, ... }: {
  # home.file.".config/hypr/wallpaper.png".source =
  #   pkgs.lib.mkDefault ./wallpaper.png;
  home.file.".config/hypr/wp.mp4".source = pkgs.lib.mkDefault ./wp.mp4;
  home.file.".config/hypr/hyprpaper.conf".text = pkgs.lib.mkDefault # hypr
    ''
      preload = ~/.config/hypr/wallpaper.png
      #if more than one preload is desired then continue to preload other backgrounds

      wallpaper = ,~/.config/hypr/wallpaper.png
      #wallpaper = monitor2,~/.config/hypr/wallpaper.jpg
      #wallpaper = monitor2,~/.config/hypr/wallpaper.jpg

    '';

  home.file.".config/hypr/hyprland.conf".text = pkgs.lib.mkDefault # hypr
    ''
      # TODO: pass monitor config from the host
      monitor=DP-2,2560x1440@170,1080x480,1
      monitor=DP-3,1920x1080@144,3640x840,1
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

          touchpad:natural_scroll = no
          sensitivity = 0
      }

      general {
          gaps_in = 8
          gaps_out = 16
          border_size = 1
          col.inactive_border = rgba(00000000) rgba(00000000) 90deg
          col.active_border = rgba(e4a88aff) rgba(00000000) 90deg
          layout = master
          allow_tearing = true
      }

      decoration {
          rounding = 0
          active_opacity = 1.0
          inactive_opacity = 0.75
          drop_shadow = false
          blur:enabled = true
          blur:size = 16
          blur:passes = 2
      }

      env = WLR_DRM_NO_ATOMIC,1
      windowrulev2 = immediate, class:^(osu!.exe)
      windowrulev2 = noblur, class:^(osu!.exe)

      misc:disable_splash_rendering = true
      misc:vfr = true
      misc:no_direct_scanout = false
      input:force_no_accel = true
      animations:enabled = no
      xwayland:force_zero_scaling = true

      master:new_is_master = false
      master:allow_small_split = true

      $mod = SUPER

      bind = $mod, s, exec, grim -g "$(slurp -d)" - | wl-copy
      bind = $mod, i, exec, kitty
      bind = $mod, b, exec, librewolf
      bind = $mod, space, exec, rofi -combi-modi drun,run,ssh -theme squared-material-red -show combi -icon-theme Papirus -show-icons

      bind = $mod, q, killactive, 
      bind = $mod shift, X, exit, 

      bind = $mod, f, fullscreen, 
      bind = $mod, t, togglefloating  
      bind = $mod, o, toggleopaque  
      bind = $mod, m, fullscreen, 1 

      # Move focus with mainMod + arrow keys
      bind = $mod, h, movefocus, l
      bind = $mod, l, movefocus, r
      bind = $mod, k, movefocus, u
      bind = $mod, j, movefocus, d

      bind = $mod control, l, resizeactive, 100 0
      bind = $mod control, h, resizeactive, -100 0
      bind = $mod control, k, resizeactive, 0 -100
      bind = $mod control, j, resizeactive, 0 100

      bind = $mod, slash, layoutmsg, swapwithmaster master
      bind = $mod, comma, layoutmsg, rollnext
      bind = $mod, period, layoutmsg, rollprev

      bind = $mod alt, l, layoutmsg, orientationright
      bind = $mod alt, h, layoutmsg, orientationleft
      bind = $mod alt, k, layoutmsg, orientationtop
      bind = $mod alt, j, layoutmsg, orientationbottom

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
      bind = $mod shift, 1, movetoworkspacesilent, 1
      bind = $mod shift, 2, movetoworkspacesilent, 2
      bind = $mod shift, 3, movetoworkspacesilent, 3
      bind = $mod shift, 4, movetoworkspacesilent, 4
      bind = $mod shift, 5, movetoworkspacesilent, 5
      bind = $mod shift, 6, movetoworkspacesilent, 6
      bind = $mod shift, 7, movetoworkspacesilent, 7
      bind = $mod shift, 8, movetoworkspacesilent, 8
      bind = $mod shift, 9, movetoworkspacesilent, 9

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      # exec-once=hyprpaper
      exec-once=waybar
      exec=otd-daemon
      exec-once=udiskie -Ns &

      exec-once=mpvpaper '*' ~/.config/hypr/wp.mp4 -o "--panscan=1 --loop"

      #disable middle click paste
      exec-once=wl-paste -p --watch wl-copy -p \'\'
    '';
}