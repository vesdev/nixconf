{ pkgs, hyprland, ... }:
let
  xwayland = pkgs.xwayland.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      (pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/hyprwm/Hyprland/8e9f010ee0bae1989279925e8f214bb18c36ba2e/nix/patches/xwayland-vsync.patch";
        hash = "sha256-VjquNMHr+7oMvnFQJ0G0whk1/253lZK5oeyLPamitOw=";
      })
    ];
  });

  package = hyprland.packages.${pkgs.system}.hyprland.override {
    inherit xwayland;  
    wlroots = hyprland.packages.${pkgs.system}.wlroots-hyprland.override {
      wlroots = pkgs.wlroots.override { inherit xwayland; };
    };
  };
in {
  programs.hyprland = {  
    enable = true;
    inherit package;
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
    hyprpaper
    waybar
  ];
}

