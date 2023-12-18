{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming/65305554cca4be9f567224ebb9e682eb5beae233";
    hyprland.url = "github:hyprwm/Hyprland";
    eza.url = "github:eza-community/eza";
    twitch-tui.url = "github:vesdev/twitch-tui";

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
