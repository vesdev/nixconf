{ config, pkgs, ... }:
{
  home.file.".config/waybar/config".source = pkgs.lib.mkDefault ./config;
  home.file.".config/waybar/style.css".source = pkgs.lib.mkDefault ./style.css;
}
