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
    comma
    tlrc

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

  services.dunst.enable = true;
  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [ rofi-calc rofi-emoji ];
      theme = "~/.local/share/rofi/themes/squared-material-red.rasi";
    };

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
