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
  };

  outputs =
    inputs:
    import ./mod {
      inherit inputs;
      hosts = [
        "pc"
        "laptop"
        "work"
        "x200"
      ];
    };
}
