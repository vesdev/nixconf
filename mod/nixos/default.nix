{ modArgs, ... }:
{
  common = import ./common.nix modArgs;
  pipewire = import ./pipewire.nix modArgs;
  hyprland = import ./hyprland.nix modArgs;
  niri = import ./niri.nix modArgs;
  gaming = import ./gaming.nix modArgs;
  network = import ./network.nix modArgs;
}
