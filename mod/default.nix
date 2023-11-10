{ inputs, pkgs, ... }:
let
  
  mod = with inputs; let 
    args = inputs // {inherit pkgs mod;};
  in {
    mkOS = import ./mkOS.nix args;
    core = import ./core.nix args;
    polybar = pkgs.callPackage ./polybar.nix {};
    pipewire = import ./pipewire.nix args;
    hyprland = import ./hyprland.nix args;
    gtk = import ./gtk.nix args;
    gaming = import ./gaming.nix args;
    network = import ./network.nix args;
    leftwm = import ./leftwm.nix args;
    dotfiles = import ./dotfiles args;
    osu-stable = nix-gaming.packages.${pkgs.system}.osu-stable;
    osu-lazer = nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
    eza = eza.packages.${pkgs.system}.default;
    packages = import ./packages.nix args;
  };
in (mod)
