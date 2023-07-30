{ config, pkgs, ... }:
{
  home.file.".config/gtk-3.0".source = ./gtk-config;
  home.file.".icons/oomox-horizon-dark".source = ./oomox-icons;
  home.file.".themes/oomox-horizon".source = ./oomox-theme;
}
