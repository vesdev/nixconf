{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chatterino2
    brightnessctl
  ];

  home.shellAliases = {
    bright = "brightnessctl s";
  };
}
