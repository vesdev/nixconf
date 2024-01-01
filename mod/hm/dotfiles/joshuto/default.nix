{ config, pkgs, ... }:
{
  home.file.".config/joshuto/mimetype.toml".source = ./mimetype.toml;
}
