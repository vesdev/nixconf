{ config, pkgs, ... }:
{
  home.file.".config/hypr/wp.mp4".source = pkgs.lib.mkDefault ./wp.mp4;

  home.file.".config/hypr/hyprlock.conf".text =
    pkgs.lib.mkDefault # hypr
      ''
        background {
          monitor =
          blur_passes = 0
        }

        label {
            monitor =
            text = locked ($USER)
            color = rgba(200, 200, 200, 1.0)
            font_size = 25
            font_family = Noto Sans
            rotate = 0 # degrees, counter-clockwise

            position = 0, 0
            halign = center
            valign = center
        }

        input-field {
            monitor =
            size = 200, 50
            outline_thickness = 3
            dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = false
            dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
            outer_color = rgb(151515)
            inner_color = rgb(200, 200, 200)
            font_color = rgb(10, 10, 10)
            fade_on_empty = true
            fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
            placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
            hide_input = false
            rounding = -1 # -1 means complete rounding (circle/oval)
            check_color = rgb(204, 136, 34)
            fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
            fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
            fail_transition = 300 # transition time in ms between normal outer_color and fail_color
            capslock_color = -1
            numlock_color = -1
            bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
            invert_numlock = false # change color if numlock is off
            swap_font_color = false # see below

            position = 0, -80
            halign = center
            valign = center
        }
      '';

  home.file.".config/hypr/hyprland.conf".text =
    pkgs.lib.mkDefault # hypr
      ''
        ${config.dotfiles.hyprland.extraConfig}

        input {
          kb_layout = de
          kb_variant = us
          touchpad:natural_scroll = no
          force_no_accel = true
          sensitivity = 0
          float_switch_override_focus=0
        }

        general {
          gaps_in = 0
          gaps_out = 0
          border_size = 0
          col.inactive_border = rgba(00000000) rgba(00000000) 90deg
          col.active_border = rgba(e4a88aff) rgba(00000000) 90deg
          layout = master
          allow_tearing = true
        }

        animations:enabled = no
        decoration {
          rounding = 0
          shadow:enabled = false
          blur:enabled = true
          blur:size = 16
          blur:passes = 2
        }

        misc {
          disable_splash_rendering = true
          disable_hyprland_logo = true
          vfr = true
          background_color = 0x1C1E26
        }

        master:allow_small_split = true

        env = WLR_DRM_NO_ATOMIC,1
        env = AQ_DRM_DEVICES,/dev/dri/card1
        xwayland:force_zero_scaling = true

        windowrulev2 = immediate, class:^(osu!.exe)
        windowrulev2 = noblur, class:^(osu!.exe)

        windowrulev2 = tag +chat, class:^(vesktop)
        windowrulev2 = tag +chat, class:^(com.chatterino.)
        windowrulev2 = tag +chat, class:^(element-desktop)
        windowrulev2 = tag +chat, class:^(fluffychat)

        windowrulev2 = workspace name:Chat, tag:chat
        layerrule = blur,rofi

        windowrulev2 = float, class:floatingAppFocus
        windowrulev2 = stayfocused, class:floatingAppFocus
        windowrulev2 = size 640 480, class:floatingAppFocus
        windowrulev2 = center, class:floatingAppFocus

        $mod = SUPER

        # screemshot
        bind = $mod, s, exec, grim -g "$(slurp)" - | swappy -f -

        # launch things
        bind = $mod, i, exec, kitty
        bind = $mod, b, exec, librewolf
        bind = $mod, space, exec, rofi -combi-modi drun,run,emoji -show combi -icon-theme Papirus -show-icons

        # close things
        bind = $mod, q, killactive, 
        bind = $mod shift, X, exit, 
        bind = $mod shift, l, exec, hyprlock

        # scale things
        bind = $mod, f, fullscreen, 
        bind = $mod, t, togglefloating  
        bind = $mod, m, fullscreen, 1 

        bind = $mod control, l, resizeactive, 100 0
        bind = $mod control, h, resizeactive, -100 0
        bind = $mod control, k, resizeactive, 0 -100
        bind = $mod control, j, resizeactive, 0 100

        # Move focus with mainMod + arrow keys
        bind = $mod, h, movefocus, l
        bind = $mod, l, movefocus, r
        bind = $mod, k, movefocus, u
        bind = $mod, j, movefocus, d

        bind = $mod shift, k, layoutmsg, swapprev
        bind = $mod shift, j, layoutmsg, swapnext

        bind = $mod, r, focuswindow, runelite
        # warframe
        bind = $mod, w, focuswindow, steam_app_230410

        bind = $mod, e, focuswindow, kitty

        # bind = $mod, slash, layoutmsg, swapwithmaster
        bind = $mod, comma, layoutmsg, rollnext
        bind = $mod, period, layoutmsg, rollprev
        bind = $mod, semicolon, layoutmsg, addmaster
        bind = $mod, p, layoutmsg, removemaster

        # rotate workspace
        bind = $mod alt, l, layoutmsg, orientationright
        bind = $mod alt, h, layoutmsg, orientationleft
        bind = $mod alt, k, layoutmsg, orientationtop
        bind = $mod alt, j, layoutmsg, orientationbottom

        # Switch workspaces with mainMod + [0-9]
        bind = $mod, 1, moveworkspacetomonitor, name:Main current
        bind = $mod, 2, moveworkspacetomonitor, name:Second current
        bind = $mod, 3, moveworkspacetomonitor, name:Chat current
        bind = $mod, 4, moveworkspacetomonitor, 4 current
        bind = $mod, 5, moveworkspacetomonitor, 5 current
        bind = $mod, 6, moveworkspacetomonitor, 6 current

        bind = $mod, 1, workspace, name:Main
        bind = $mod, 2, workspace, name:Second
        bind = $mod, 3, workspace, name:Chat
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mod shift, 1, movetoworkspacesilent, name:Main
        bind = $mod shift, 2, movetoworkspacesilent, name:Second
        bind = $mod shift, 3, movetoworkspacesilent, name:Chat
        bind = $mod shift, 4, movetoworkspacesilent, 4
        bind = $mod shift, 5, movetoworkspacesilent, 5
        bind = $mod shift, 6, movetoworkspacesilent, 6

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow

        bind=$mod,g,exec,wl-kbptr 

        # exec-once=hyprpaper
        exec-once=waybar
        exec=otd-daemon
        exec-once=udiskie -Ns &
        exec = gsettings set org.gnome.desktop.interface gtk-theme "YOUR_DARK_GTK3_THEME"   # for GTK3 apps
        exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps

        env = QT_QPA_PLATFORM,wayland

        # exec-once=mpvpaper '*' ~/.config/hypr/wp.mp4 -o "--panscan=1 --loop --hwdec=vaapi"
        # exec-once = wl-paste -t text -w xclip -selection clipboard
      '';
}
