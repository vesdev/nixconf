{ inputs, hosts, pkgs }: with inputs; {
  hyprland = hyprland.packages.${pkgs.system}.hyprland;
  hyprlock = hyprlock.packages.${pkgs.system}.hyprlock;
  wlroots-hyprland = hyprland.packages.${pkgs.system}.wlroots-hyprland;
  xdg-desktop-portal-hyprland = hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  osu-stable = nix-gaming.packages.${pkgs.system}.osu-stable;
  osu-lazer = nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
  helix = helix.packages.${pkgs.system}.default;
  bo = bo.packages.${pkgs.system}.default;
}
