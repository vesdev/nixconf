{ inputs, pkgs, ... }:
let
  
  mod = with inputs; let 
    args = inputs // {inherit pkgs mod;};
  in {
    mkOS = import ./mkOS.nix args;
    core = import ./core.nix args;
    pipewire = import ./pipewire.nix args;
    hyprland = import ./hyprland args;
    gtk = import ./gtk.nix args;
    gaming = import ./gaming.nix args;
    network = import ./network.nix args;
    vagrant-network = import ./vagrant-network.nix;
    dotfiles = import ./dotfiles args;

    bitwig-studio = import ./bitwig.nix {};
    osu-stable = nix-gaming.packages.${pkgs.system}.osu-stable;
    osu-lazer = nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
    eza = eza.packages.${pkgs.system}.default;
    helix = helix.packages.${pkgs.system}.default;
    twitch-tui = twitch-tui.packages.${pkgs.system}.default;
    # agenix-cli = agenix.packages.${pkgs.system}.default;
    # agenix = agenix.nixosModules.default;

    # stuff thats not currently being used that takes long to build
    # leftwm = import ./leftwm.nix args;
    # polybar = pkgs.callPackage ./polybar.nix {};
    packages = import ./packages.nix args;
  };
in (mod)
