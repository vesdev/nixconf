{ mod, pkgs, ... }:
{ host, ... }:
{
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
    yazi
    buku
    mod.pkgs.bo

    # deps
    libinput
    nodePackages_latest.pnpm
    # linuxPackages_latest.perf
    openjdk
    pamixer
    pulseaudio
    nixpkgs-fmt
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
    vesktop
    chatterino2
    mullvad-vpn
    zathura
  ];

  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];
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

    cava = {
      enable = true;
      settings.color = {
        foreground = "'#EE64AE'";
      };
    };
  };
}
