{ pkgs, mod, ... }:
{
  environment.variables.NIXOS_OZONE_WL = "1";

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd "niri-session"
      '';
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    mod.pkgs.niri
    mod.pkgs.ashell
    mod.pkgs.xwayland-satellite
    gamescope
    swww
    wayland
    wdisplays
    hyprpaper
    waybar
    grim
    slurp
    wl-clipboard
    mod.pkgs.hyprlock
    nautilus
  ];
}
