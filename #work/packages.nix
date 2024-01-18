{ pkgs, ... }: {
  home.packages = with pkgs; [
    ngrok
    qmk
    ungoogled-chromium
    brightnessctl
    openssl
  ];

  home.shellAliases = { bright = "brightnessctl s"; };
}
