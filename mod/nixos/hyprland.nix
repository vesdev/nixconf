{ pkgs, mod, ... }:
{
  environment.variables.NIXOS_OZONE_WL = "1";

  programs.hyprland = {
    enable = true;
    # portalPackage = mod.pkgs.xdg-desktop-portal-hyprland;
    # package = mod.pkgs.hyprland;
    # inherit package;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd Hyprland
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

  environment.systemPackages = with pkgs; [
    wayland
    wdisplays
    hyprpaper
    mpvpaper
    waybar
    grim
    slurp
    wl-clipboard
    hyprlock
    # mod.pkgs.hyprlock
    xclip
    wl-kbptr
  ];
}
