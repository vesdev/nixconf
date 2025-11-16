{ mod, pkgs, ... }:
{ host, ... }:
let
  profile = "7mnqrikw.default";
in
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

    # other
    mpv
    kitty
    swappy

    # apps
    # xfce.thunar
    xarchiver
    pwvucontrol
    vesktop
    mullvad-vpn
    zathura
    firefoxpwa
  ];

  services.arrpc.enable = true;
  programs =
    {
      home-manager.enable = true;

      rofi = {
        enable = true;
        # package = pkgs.rofi-wayland;
        theme = "~/.local/share/rofi/themes/squared-material-red.rasi";
      };

      firefox =
        {
          enable = true;
          package = pkgs.librewolf;
          nativeMessagingHosts = with pkgs; [ firefoxpwa tridactyl-native ];

          profiles.${profile}.settings = {
            "webgl.disabled" = false;
            "privacy.resistFingerprinting" = false;
            "media.ffmpeg.vaapi.enabled" = true;

            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "svg.context-properties.content.enabled" = true;
            "layout.css.has-selector.enabled" = true;
            "browser.urlbar.suggest.calculator" = true;
            "browser.urlbar.unitConversion.enabled" = true;
            "browser.urlbar.trimHttps" = true;
            "browser.urlbar.trimURLs" = true;
            "browser.profiles.enabled" = true;
            "widget.gtk.rounded-bottom-corners.enabled" = true;
            "browser.compactmode.show" = true;
            "widget.gtk.ignore-bogus-leave-notify" = 1;
            "browser.tabs.allow_transparent_browser" = true;
            "browser.uidensity" = 1;
            "browser.aboutConfig.showWarning" = false;
          };
        };

    };
  # home.file.".librewolf/${profile}/chrome" = {
  #   source = "${mod.pkgs.potatofox}/chrome";
  #   recursive = true;
  # };

  # home.file.".librewolf/${profile}/Sidebery-Data.json" = {
  #   source = "${mod.pkgs.potatofox}/Sidebery-Data.json";
  #   # recursive = true;
  # };
}
