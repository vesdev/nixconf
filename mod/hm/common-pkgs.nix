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
    scan = "iwctl station wlan0 scan";
  };
in {
  home.packages = with pkgs; [
    # cli/tui
    gh
    neofetch
    jq
    bottom
    lazygit
    appimage-run
    eza
    sshfs
    ripgrep
    mod.pkgs.helix
    glow
    bat
    bat-extras.batgrep
    bat-extras.prettybat
    xorg.xprop
    du-dust

    # deps
    libinput
    nodePackages_latest.pnpm
    linuxPackages_latest.perf
    openjdk
    pamixer
    pulseaudio
    nixfmt
    nil
    taplo
    marksman
    xdg-utils
    xdg-terminal-exec
    unrar
    udiskie
    mpvpaper

    # other
    mpv
    feh
    kitty

    # apps
    xfce.thunar
    xarchiver
    pavucontrol
    webcord-vencord
    chatterino2
    mullvad-vpn
    zathura
    keepassxc
  ];

  programs = {
    home-manager.enable = true;

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

    librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
  };
}
