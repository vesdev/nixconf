{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming/bf9a8a83f9c9fc75b01c8467b4d1432e79dcc6ca";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprlock.url = "github:hyprwm/hyprlock";
    helix.url = "github:helix-editor/helix";
    musnix.url = "github:musnix/musnix";
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
      ];
    };
}
