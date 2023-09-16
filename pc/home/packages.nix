{ pkgs, ...}:
{
  home.packages = with pkgs; [  
    qmk
    krita
    handbrake
    chatterino2
    obs-studio
    osu-stable
    osu-lazer-bin
  ];
}
