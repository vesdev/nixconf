{ ... }:
{
  services.dunst.settings = {
    global = {
      monitor = 1;
      width = 500;
      height = 100;
      offset = "32x32";
      origin = "left-center";
      font = "FiraCode Nerd Font 16";
    };

    urgency_normal = {
      background = "#1c1e26";
      foreground = "#e0e0e0";
      timeout = 5;
    };
  };
}
