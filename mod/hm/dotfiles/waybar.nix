{ config, pkgs, ... }:
{
  home.file.".config/waybar/config".text = # json
    ''
      {
      ${config.dotfiles.waybar.extraConfig}

      "layer": "top",

      "position": "top",

      // If height property would be not present, it'd be calculated dynamically
      "height": 30,
      "battery": {
        "interval": 10,
        "states": {
            "warning": 30,
            "critical": 15
        },
        // Connected to AC
        "format": "  {icon}  {capacity}%", // Icon: bolt
        // Not connected to AC
        "format-discharging": "{icon}  {capacity}%",
        "format-icons": [
            "", // Icon: battery-full
            "", // Icon: battery-three-quarters
            "", // Icon: battery-half
            "", // Icon: battery-quarter
            ""  // Icon: battery-empty
        ],
        "tooltip": true
      },

      "clock#time": {
        "interval": 1,
        "format": "{:%H:%M:%S}",
        "tooltip": false
      },

      "clock#date": {
      "interval": 10,
      "format": "  {:%e %b %Y}", // Icon: calendar-alt
      "tooltip-format": "{:%e %B %Y}"
      },

      "cpu": {
        "interval": 5,
        "format": "  {usage}% ({load})", // Icon: microchip
        "states": {
          "warning": 70,
          "critical": 90
        }
      },

      "custom/keyboard-layout": {
          "exec": "swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | cut -d '\"' -f4",
          // Interval set only as a fallback, as the value is updated by signal
          "interval": 30,
          "format": "  {}", // Icon: keyboard
          // Signal sent by Sway key binding (~/.config/sway/key-bindings)
          "signal": 1, // SIGHUP
          "tooltip": false
      },

      "memory": {
        "interval": 5,
        "format": "  {}%", // Icon: memory
        "states": {
            "warning": 70,
            "critical": 90
        }
      },

      "network": {
        "interval": 5,
        "format-wifi": "  {essid} ({signalStrength}%)", // Icon: wifi
        "format-ethernet": "  {ifname}: {ipaddr}/{cidr}", // Icon: ethernet
        "format-disconnected": "⚠  Disconnected",
        "tooltip-format": "{ifname}: {ipaddr}"
      },

      "hyprland/mode": {
        "format": "<span style=\"italic\">  {}</span>", // Icon: expand-arrows-alt
        "tooltip": false
      },

      "hyprland/window": {
        "format": "{}",
        "max-length": 120
      },

      "hyprland/workspaces": {
        "format": "{icon}",
        "all-outputs": true,
        "disable-scroll": true,
        "format-icons": {
          "Main": "",  
          "Chat": "󰭹",  
          "Second": "",  
        },
      },

      "pulseaudio": {
        //"scroll-step": 1,
        "format": "{icon}  {volume}%",
        "format-bluetooth": "{icon}  {volume}%",
        "format-muted": "",
        "format-icons": {
            "headphones": "",
            "handsfree": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", ""]
        },
        "on-click": "pwvucontrol"
      },

      "temperature": {
      "critical-threshold": 80,
      "interval": 5,
      "format": "{icon}  {temperatureC}°C",
      "format-icons": [
          "", // Icon: temperature-empty
          "", // Icon: temperature-quarter
          "", // Icon: temperature-half
          "", // Icon: temperature-three-quarters
          ""  // Icon: temperature-full
      ],
      "tooltip": true
      },

      "tray": {
        "icon-size": 21,
        "spacing": 10
      }
      }
    '';

  home.file.".config/waybar/style.css".text =
    pkgs.lib.mkDefault # css
      ''
        @keyframes blink-warning {
            70% {
                color: white;
            }

            to {
                color: white;
                background-color: orange;
            }
        }

        @keyframes blink-critical {
            70% {
              color: white;
            }

            to {
                color: white;
                background-color: red;
            }
        }


        /* Reset all styles */
        * {
            border: none;
            border-radius: 0;
            min-height: 0;
            margin: 0;
            padding: 0;
        }

        /* The whole bar */
        #waybar {
            background: rgba(0, 0, 0, 0);
            color: #e4a88a;
            font-family: Fira Code, monospace;
            font-size: 14px;
        }

        /* Each module */
        #battery,
        #clock,
        #cpu,
        #custom-keyboard-layout,
        #memory,
        #mode,
        #network,
        #pulseaudio,
        #temperature,
        #tray {
            padding-left: 5px;
            padding-right: 5px;
        }

        .modules-right,
        .modules-left {
            background-color: rgba(0, 0, 0, 0);
            border-radius: 0px;
        }

        .modules-left {
            margin-left: 16px;
        }

        .modules-right {
            margin-right: 16px;
        }

        .modules-center {
            border-bottom: 1px solid #e4a88a;
        }

        /* module styles */
        #battery {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #battery.warning {
            color: orange;
        }

        #battery.critical {
            color: red;
        }

        #battery.warning.discharging {
            animation-name: blink-warning;
            animation-duration: 3s;
        }

        #battery.critical.discharging {
            animation-name: blink-critical;
            animation-duration: 2s;
        }

        #clock {
            font-weight: bold;
        }

        #cpu {
          /* No styles */
        }

        #cpu.warning {
            color: orange;
        }

        #cpu.critical {
            color: red;
        }

        #memory {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #memory.warning {
            color: orange;
        }

        #memory.critical {
            color: red;
            animation-name: blink-critical;
            animation-duration: 2s;
        }

        #mode {
            background: #64727D;
            border-top: 2px solid white;
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
        }

        #network {
            /* No styles */
        }

        #network.disconnected {
            color: orange;
        }

        #pulseaudio {
            /* No styles */
        }

        #pulseaudio.muted {
            /* No styles */
        }

        #custom-spotify {
            color: rgb(102, 220, 105);
        }

        #temperature {
            /* No styles */
        }

        #temperature.critical {
            color: red;
        }

        #tray {
            /* No styles */
        }

        #window {
            font-weight: bold;
        }

        #workspaces button {
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 10px;
            color: #e4a88a;
        }

        #workspaces button.focused {
            color: #e95378;
        }

        #workspaces button.urgent {
            border-color: #c9545d;
            color: #c9545d;
        }

      '';
}
