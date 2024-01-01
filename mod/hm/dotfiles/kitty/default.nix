{ config, pkgs, ... }:
{
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
  home.file.".config/kitty/theme.conf".source = ./theme.conf;
}
