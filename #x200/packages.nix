{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ngrok
    qmk
    ungoogled-chromium
    brightnessctl
    openssl
    ffmpeg
    vscodium
    alacritty
  ];

  home.shellAliases = {
    bright = "brightnessctl s";
  };
}
