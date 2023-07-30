{ config, pkgs, ... }:
{
  home.file.".xprofile".source = ./.xprofile;
}
