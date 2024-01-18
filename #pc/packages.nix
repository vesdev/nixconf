{ pkgs, mod, ... }: {
  home.packages = with pkgs;
    with mod.pkgs; [
      ungoogled-chromium
      vscodium
      qmk
      krita
      handbrake
      chatterino2
      obs-studio
      (osu-stable.override { location = "$HOME/.local/share/osu-stable"; })
      osu-lazer
      kitty
      qbittorrent
      yabridge
      yabridgectl
      ferium
      prismlauncher
    ];
}
