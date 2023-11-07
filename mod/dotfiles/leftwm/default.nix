{ config, pkgs, ... }:
{
  home.file.".config/leftwm/config.ron".source = ./config.ron;
  home.file.".config/leftwm/themes/current".source = ./theme;
}
