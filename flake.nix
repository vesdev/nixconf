{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    hyprland.url = "github:hyprwm/hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    helix.url = "github:helix-editor/helix";
    bo.url = "github:vesdev/bo";
    niri = {
      url = "github:YaLTeR/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ashell.url = "github:MalpenZibo/ashell";

    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    potatofox = {
      url = "git+https://codeberg.org/awwpotato/PotatoFox";
      flake = false;
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    keebi.url = "github:vesdev/keebi";
  };

  outputs =
    inputs:
    import ./mod {
      inherit inputs;
      hosts = [
        "pc"
        "laptop"
        "x200"
      ];
    };
}
