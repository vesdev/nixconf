{ modArgs, ... }:
{
  gtk = import ./gtk.nix modArgs;
  xdg = import ./xdg.nix modArgs;
  dotfiles = import ./dotfiles modArgs;
  common-pkgs = import ./common-pkgs.nix modArgs;
}
