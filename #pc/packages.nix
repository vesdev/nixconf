{ pkgs, mod, ... }:
{
  home.packages =
    with pkgs;
    with mod.pkgs;
    [
      # (osu-stable.override { location = "$HOME/.local/share/osu-stable"; })
      # mod.pkgs.twitch-tui
      blender
      ungoogled-chromium
      vscodium
      qmk
      krita
      # handbrake
      chatterino2
      obs-studio
      osu-lazer
      kitty
      qbittorrent
      yabridge
      yabridgectl
      ferium
      prismlauncher
      lutgen
      ffmpeg
      piper
      element-desktop
      bottles
      nuclear
    ];
}
