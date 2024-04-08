{ ... }: {
  services.dunst.configFile = ''
    geometry = 300x50-32+32
    monitor = 0

    [urgency_normal]
    background = "#1c1e26"
    foreground = "#e0e0e0"
    timeout = 5
  '';
}
