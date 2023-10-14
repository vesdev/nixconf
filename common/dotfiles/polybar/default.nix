{ config, pkgs, ... }:
{
  home.file.".config/polybar/common.config".source = ./common.config;
  home.file.".config/polybar/scripts".source = ./scripts;
}
