{ pkgs, mod, config, ... }:
{

  home.packages =
    with pkgs;
    with mod.pkgs;
    [
      # (osu-stable.override { location = "$HOME/.local/share/osu-stable"; })
      # mod.pkgs.twitch-tui
      carla
      blender
      ungoogled-chromium
      qmk
      krita
      pcsx2

      # handbrake
      chatterino2
      mod.pkgs.osu-lazer
      qbittorrent
      yabridge
      yabridgectl
      prismlauncher
      lutgen
      ffmpeg
      piper
      # fluffychat
      tor-browser
      helvum
      guitarix
      wineWowPackages.stagingFull
      dislocker
      hoppscotch
      runelite
      bolt-launcher
      ngrok
      dolphin-emu
      signal-desktop
      rusty-man

      muffon
      overskride
      bluez
      godot_4
      libreoffice
    ];

  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.obs-pipewire-audio-capture ];
  };

  # systemd.services.mullvad-daemon.path = [
  #   config.networking.resolvconf.package
  # ];
}
