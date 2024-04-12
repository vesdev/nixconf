{ pkgs, ... }:
{
  home.file.".config/swayidle/config".text = pkgs.lib.mkDefault ''
    timeout 1800 'swaylock -f'
    timeout 1805 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
    before-sleep 'swaylock -f'
    lock 'swaylock -f'
  '';
}
