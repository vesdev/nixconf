{ inputs, hosts }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  # temporary mod attr set
  # for module internal use
  mod = {
    pkgs = with inputs; {
      hyprland = hyprland.packages.${pkgs.system}.hyprland;
      wlroots-hyprland = hyprland.packages.${pkgs.system}.wlroots-hyprland;
      osu-stable = nix-gaming.packages.${pkgs.system}.osu-stable;
      osu-lazer = nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
      eza = eza.packages.${pkgs.system}.default;
      helix = helix.packages.${pkgs.system}.default;
      twitch-tui = twitch-tui.packages.${pkgs.system}.default;
    };

    nixosModules = {
      pipewire = inputs.nix-gaming.nixosModules.pipewireLowLatency;
    };
  };

  modArgs = { inherit pkgs mod; };

  # construct final mod attr set
  mod = {
    inherit (mod.pkgs);
    # nixos modules
    nixos = import ./nixos { inherit modArgs; };
    # home-manager modules
    hm = import ./hm { inherit modArgs; };
  };
in with inputs; (import ./hosts.nix { inherit nixpkgs home-manager mod pkgs; } hosts)
