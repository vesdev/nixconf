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
    #not in use
    # mod.polybar
    # flameshot
    # zellij
    # cava

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
    mod.pkgs.twitch-tui
    xorg.xprop

    # deps
    libinput
    nodePackages_latest.pnpm
    linuxPackages_latest.perf
    openjdk
    pamixer
    pulseaudio
    nixfmt
    nil
    marksman
    xdg-utils
    xdg-terminal-exec
    unrar
    udiskie

    # system
    xfce.thunar
    xarchiver
    pavucontrol
    mpv
    feh
    kitty
    arandr

    # apps
    librewolf
    webcord-vencord
    # (pkgs.discord.override {
    #   # remove any overrides that you don't want
    #   withopenasar = true;
    #   withvencord = true;
    #   nss = nss_latest;
    # })
    chatterino2
    mullvad-vpn
    zathura
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
      '';
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
