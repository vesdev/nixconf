{ modArgs, ... }:
{
  gtk = import ./gtk.nix modArgs;
  xdg = import ./xdg.nix modArgs;
  dotfiles = import ./dotfiles modArgs;
  shell = import ./shell.nix modArgs;
  common-pkgs = import ./common-pkgs.nix modArgs;
}
