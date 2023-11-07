{ inputs, pkgs, ... }:
let
  args = inputs // {inherit pkgs;};
  
  mod = with inputs; {
    mkOS = import ./mkOS.nix {};
    core = import ./core.nix args;
    polybar = pkgs.callPackage ./polybar.nix {};
    pipewire = import ./pipewire.nix args;
    hyprland = import ./hyprland.nix args;
    gtk = import ./gtk.nix args;
    gaming = import ./gaming.nix args;
    network = import ./network.nix args;
    leftwm = import ./leftwm.nix args;
    dotfiles = import ./dotfiles args;
    joshuto = joshuto.packages.${pkgs.system}.default;
    osu-stable = nix-gaming.packages.${pkgs.system}.osu-stable;
    osu-lazer = nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
    packages = import ./packages.nix (args // {inherit mod;});
  };
in (mod)
