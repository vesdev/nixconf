{ pkgs, mod, config, ... }:
{

  home.packages =
    with pkgs;
    with mod.pkgs;
    [
      # (osu-stable.override { location = "$HOME/.local/share/osu-stable"; })
      # mod.pkgs.twitch-tui
      # carla
      blender
      ungoogled-chromium
      qmk
      krita
      pcsx2

      # handbrake
      chatterino2
      (mod.pkgs.osu-lazer.override {
        releaseStream = "tachyon";
      })
      qbittorrent
      prismlauncher
      lutgen
      ffmpeg
      piper

      # fluffychat
      tor-browser
      helvum
      wineWowPackages.stagingFull

      yabridge
      yabridgectl

      dislocker
      hoppscotch
      runelite
      (bolt-launcher.override { enableRS3 = true; })
      ngrok
      dolphin-emu
      signal-desktop
      rusty-man

      muffon
      overskride
      bluez
      godot
      libreoffice
      element-desktop
      protonup-qt
      kdePackages.kdenlive
      python3
      python3Packages.pip
      keymapp
      tonelib-metal
      tonelib-gfx
      tonelib-jam
      labwc
      tesseract
      qwen-code
      keebi
    ];

  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.obs-pipewire-audio-capture ];
  };


  # systemd.services.mullvad-daemon.path = [
  #   config.networking.resolvconf.package
  # ];
}
