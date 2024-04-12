{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ngrok
    qmk
    ungoogled-chromium
    brightnessctl
    openssl
    ffmpeg
  ];

  home.shellAliases = {
    bright = "brightnessctl s";
  };
}
