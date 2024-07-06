{ inputs, hosts }:
let

  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  # mod attr set
  # destructures stuff for ease of use
  mod = {
    pkgs = with inputs; {
      hyprland = hyprland.packages.${pkgs.system}.hyprland;
      hyprlock = hyprlock.packages.${pkgs.system}.hyprlock;
      wlroots-hyprland = hyprland.packages.${pkgs.system}.wlroots-hyprland;
      xdg-desktop-portal-hyprland = hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      osu-stable = nix-gaming.packages.${pkgs.system}.osu-stable;
      osu-lazer = nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
      helix = helix.packages.${pkgs.system}.default;
      niri = niri.packages.${pkgs.system}.default;
      # vueko-backend = inputs.vuekobot.packages.${pkgs.system}.vueko-backend;
      # vueko-frontend = inputs.vuekobot.packages.${pkgs.system}.vueko-frontend;
      # cachyos = chaotic.packages.${pkgs.system}.linuxPackages_cachyos;
      # scx = chaotic.packages.${pkgs.system}.scx;
    };

    nixosModules = {
      pipewire = inputs.nix-gaming.nixosModules.pipewireLowLatency;
      # vuekobot = inputs.vuekobot.nixosModules.default;
      # chaotic = inputs.chaotic.nixosModules.default;
      home-manager = inputs.home-manager.nixosModules.home-manager;
    };
  };

  modArgs = {
    inherit pkgs mod;
  };

  # nixos modules
  mod."nixos" = import ./nixos { inherit modArgs; };
  # home-manager modules
  mod."hm" = import ./hm { inherit modArgs; };
in
with inputs;
(import ./hosts.nix {
  inherit
    nixpkgs
    home-manager
    mod
    pkgs
    ;
} hosts)
