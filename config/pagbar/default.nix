{ config, pkgs, ... }:
{
  home.file.".config/pagbar/config.toml".source = ./config.toml;
}
