{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    wayland
    wdisplays
    wofi
  ];
}
