{ config, pkgs, ... }:
{
  home.file.".config/polybar/polybar.config".source = ./polybar.config;
  # home.file.".config/polybar/scripts".source = ./scripts;
}
