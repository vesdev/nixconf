{ pkgs, ... }: {
  home.packages = with pkgs; [ ngrok ungoogled-chromium brightnessctl openssl ];

  home.shellAliases = { bright = "brightnessctl s"; };
}
