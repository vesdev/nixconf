{ config, pkgs, ... }:
{
  home.file.".config/helix/languages.toml".source = ./languages.toml;
  home.file.".config/helix/config.toml".source = ./config.toml;
  # home.file.".config/helix/themes/keko.toml".source = ./keko.toml;
  # home.file.".config/helix/themes/horizon-dark.toml".source = ./horizon-dark.toml;
}
