{ pkgs, myPkgs, ... }:
{
  programs.hyprland = {  
    enable = true;
    package = myPkgs.hyprland;
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

  # environment.etc."greetd/environments".text = ''
  #   Hyprland
  # '';

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
    wofi
  ];
}

