{ pkgs, ...}:
{
  home.packages = with pkgs; [  
    chatterino2
     brightnessctl   
    brave
    firefox
    openssl
  ];
  
  home.shellAliases = {
    bright = "brightnessctl s";
  };
}
