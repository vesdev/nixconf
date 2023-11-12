{ config, pkgs, ... }:
{
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
