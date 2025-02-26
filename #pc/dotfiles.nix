{ ... }:
{
  dotfiles = {
    hyprland.extraConfig = # bash
      ''
        monitor=DP-2,1920x1080@144,0x840,1
        monitor=DP-3,2560x1440@170,1920x480,1
        monitor=HDMI-A-1,1920x1080@60,4480x0,1,transform,1
        workspace=name:Main, monitor:DP-3, default:true
        workspace=name:Second, monitor:DP-2, default:true
        workspace=name:Chat, monitor:HDMI-A-1, default:true, layoutopt:orientation:left, layoutopt:new_is_master:true
        exec-once=vesktop
        exec-once=chatterino
        exec-once=fluffychat
      '';

    waybar.extraConfig = # bash
      ''
        "output": [ "DP-3" ],
        "modules-left": [
          "hyprland/workspaces",
          "hyprland/mode"
        ],
        "modules-center": [
          "clock#time",
        ],
        "modules-right": [
          "pulseaudio",
          "network",
          "memory",
          "cpu",
          "temperature",
          "battery",
          "tray",
          "clock#date",
        ],
      '';
  };
}
