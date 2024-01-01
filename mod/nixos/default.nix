{ modArgs, ... }:
{
  core = import ./core.nix modArgs;
  pipewire = import ./pipewire.nix modArgs;
  hyprland = import ./hyprland.nix modArgs;
  gaming = import ./gaming.nix modArgs;
  network = import ./network.nix modArgs;
}
