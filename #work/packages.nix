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
  ];

  home.shellAliases = {
    bright = "brightnessctl s";
  };
}
