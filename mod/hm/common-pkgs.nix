{ mod, pkgs, ... }:
{ host, ... }:
{
  home.packages = with pkgs; [
    # cli/tui
    gh
    hyfetch
    jq
    bottom
    lazygit
    appimage-run
    eza
    sshfs
    ripgrep
    mod.pkgs.helix
    bat
    bat-extras.batgrep
    bat-extras.prettybat
    xorg.xprop
    du-dust
    comma
    tlrc
    mod.pkgs.bo
    skim

    # deps
    libinput
    # openjdk
    nixpkgs-fmt
    nil
    taplo
    marksman
    xdg-utils
    xdg-terminal-exec
    unrar
    udiskie
    lldb_16

    # other
    mpv
    kitty
    swappy

    # apps
    xfce.thunar
    xarchiver
    pwvucontrol
    vesktop
    mullvad-vpn
    zathura
  ];

  services.arrpc.enable = true;
  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
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
