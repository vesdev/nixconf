{ pkgs, myPkgs, ...}:
{
  home.packages = with pkgs; with myPkgs; [  
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
    osu-lazer
  ];
}
