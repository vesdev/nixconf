{ config, pkgs, ... }:
{
  home.file.".config/niri/config.kdl".text = #kdl
    ''
      input {
            keyboard {
                xkb {
                    layout "de"
                    variant "us"
                }
            }

            touchpad {
                tap
                natural-scroll
                accel-profile "flat"
            }

            mouse {
                accel-profile "flat"
            }

            tablet {
                map-to-output "DP-3"
            }

            warp-mouse-to-focus
            focus-follows-mouse max-scroll-amount="0%"
        }

        hotkey-overlay { skip-at-startup; }

        layer-rule {
            match namespace="^wallpaper$"

            place-within-backdrop true
        }

        window-rule {
            geometry-corner-radius 12
            clip-to-geometry true
        }

        window-rule {
            match app-id="^vesktop$"

            block-out-from "screencast"
        }

        output "DP-3" {
            mode "2560x1440@170.021"
            transform "normal"
            position x=1920 y=1080
            focus-at-startup
        }

        output "DP-2" {
            mode "1920x1080@144.001"
            transform "normal"
            position x=0 y=1440
        }

        output "HDMI-A-1" {
            mode "1920x1080@74.986"
            position x=1920 y=0
            background-color "#1C1E26"
        }

        layout {
            gaps 16
            center-focused-column "never"

            preset-column-widths {
                proportion 0.33333
                proportion 0.5
                proportion 0.66667
            }

            default-column-width { proportion 0.5; }

            focus-ring {
                off
                width 1

                active-color "#353747"
                inactive-color "#2E303E"
            }

            background-color "transparent"
    
        }

        screenshot-path null
        prefer-no-csd
        spawn-at-startup "waybar"
        spawn-at-startup "xwayland-satellite"
        spawn-at-startup "swww-daemon"

        environment {
            DISPLAY ":0"
            ELECTRON_OZONE_PLATFORM_HINT "auto"
            _JAVA_AWT_WM_NONREPARENTING "1"
        }

        animations {
            off
        }

        binds {
            Mod+I { spawn "kitty"; }
            Mod+B { spawn "librewolf"; }
            Mod+Space { spawn "rofi" "-combi-modi" "drun,run,emoji" "-show" "combi" "-icon-theme" "Papirus" "-show-icons"; }

            Mod+O { open-overview; }

            Mod+Q { close-window; }

            Mod+H { focus-column-left; }
            Mod+J { focus-window-down; }
            Mod+K { focus-window-up; }
            Mod+L { focus-column-right; }

            Mod+C { center-column; }
            Mod+E { expand-column-to-available-width; }

            Mod+N { move-column-left; }
            Mod+M { move-column-right; }

            Mod+Ctrl+H { consume-or-expel-window-left; }
            Mod+Ctrl+J { move-window-down; }
            Mod+Ctrl+K { move-window-up; }
            Mod+Ctrl+L { consume-or-expel-window-right; }

            Mod+Shift+H { focus-monitor-left; }
            Mod+Shift+J { focus-monitor-down; }
            Mod+Shift+K { focus-monitor-up; }
            Mod+Shift+L { focus-monitor-right; }

            Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
            Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
            Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
            Mod+Shift+Ctrl+L { move-column-to-monitor-right; }

            Mod+U { focus-workspace-up; }
            Mod+D { focus-workspace-down; }
            Mod+Ctrl+U { move-column-to-workspace-up; }
            Mod+Ctrl+D { move-column-to-workspace-down; }

            Mod+Shift+U { move-workspace-up; }
            Mod+Shift+D { move-workspace-down; }

            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }
            Mod+6 { focus-workspace 6; }
            Mod+7 { focus-workspace 7; }
            Mod+8 { focus-workspace 8; }
            Mod+9 { focus-workspace 9; }
            Mod+Shift+1 { move-column-to-workspace 1; }
            Mod+Shift+2 { move-column-to-workspace 2; }
            Mod+Shift+3 { move-column-to-workspace 3; }
            Mod+Shift+4 { move-column-to-workspace 4; }
            Mod+Shift+5 { move-column-to-workspace 5; }
            Mod+Shift+6 { move-column-to-workspace 6; }
            Mod+Shift+7 { move-column-to-workspace 7; }
            Mod+Shift+8 { move-column-to-workspace 8; }
            Mod+Shift+9 { move-column-to-workspace 9; }

            Mod+R { switch-preset-column-width; }
            Mod+Shift+R { reset-window-height; }
            Mod+Shift+F { maximize-column; }
            Mod+F { fullscreen-window; }
            Mod+T { toggle-window-floating; }

            Mod+Comma { set-column-width "-10%"; }
            Mod+Period { set-column-width "+10%"; }
            Mod+Shift+Comma { set-window-height "-10%"; }
            Mod+Shift+Period { set-window-height "+10%"; }

            Mod+P { screenshot; }
            Mod+semicolon { spawn-sh "wl-paste --type image/png | tesseract - - | wl-copy"; }

            Mod+Shift+X { quit; }
        }

    '';
}

