{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    hyprland.url =
      "github:hyprwm/Hyprland/12d79d63421e2ed3f31130755c7a37f0e4fb5cb1";
    eza.url = "github:eza-community/eza";
    twitch-tui.url = "github:vesdev/twitch-tui";
    helix.url = "github:vesdev/helix";
  };

  outputs = inputs:
    import ./mod {
      inherit inputs;
      hosts = [ "pc" "laptop" "work" ];
    };
}
