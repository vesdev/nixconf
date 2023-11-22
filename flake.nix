{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    hyprland.url = "github:hyprwm/Hyprland";
    eza.url = "github:eza-community/eza";

    # not in use
    # leftwm.url = "github:leftwm/leftwm";
  };

  outputs = inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in (import ./mod { inherit inputs pkgs; }).mkOS [
      "pc"
      "laptop"
      "work"
    ];
}
