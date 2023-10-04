{ pkgs, ...}:
{
  home.packages = with pkgs; [  
    brave
    vscodium
    qmk
    krita
    handbrake
    chatterino2
    obs-studio
    (osu-stable.override {
      location = "$HOME/.local/share/osu-stable";
    })
    osu-lazer-bin
  ];
}
