{ config, pkgs, ... }:
{
  home.file.".bashrc".source = ./.bashrc;
  home.file.".bash_completion/alacritty".source = ./bash-completion;
}
