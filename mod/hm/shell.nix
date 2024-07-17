{ mod, pkgs, ... }:
{ host, ... }:
let
  shellAliases = {
    nd = "nix develop";
    nl = "echo $SHLVL";
    ngc = "sudo nix-collect-garbage -d";
    lg = "lazygit";
    ls = "eza";
    switch = "sudo nixos-rebuild switch --flake .#${host}";
    cat = "bat";
    rg = "batgrep";
    cr = "clear && cargo run";
    scan = "iwctl station wlan0 scan";
    b = "buku";
  };
in
{
  programs = {
    zoxide.enable = true;
    zoxide.enableBashIntegration = true;
    bash = {
      enable = true;
      inherit shellAliases;

      bashrcExtra = ''
        export MANPAGER="sh -c 'col -bx | bat -l man -p'"
        export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
        export PATH=$PATH:/var/lib/flatpak/exports/bin
        export VIRSH_DEFAULT_CONNECT_URI=qemu:///system
      '';
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
