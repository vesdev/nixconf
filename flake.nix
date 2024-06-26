{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    eza.url = "github:eza-community/eza";
    twitch-tui.url = "github:Xithrius/twitch-tui";
    helix.url = "github:helix-editor/helix";
    vuekobot.url = "github:vesdev/vuekobot";
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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
