{ config, pkgs, home-manager, ...}:
let
  username = "ves"; 
in {
  imports = [
    ../../common/gaming.nix
    ../../common/network.nix
    ../../common/leftwm.nix
    # ../../common/sway.nix
    ../../common/pipewire.nix

    {
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "video" ]; 
        initialPassword = username;
      };

      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
      '';

      nix.settings.trusted-users = [ "ves" ];

      xdg.mime.defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
      };

      services.udev.packages = [ pkgs.qmk-udev-rules ];
      environment = {
        variables.SUDO_EDITOR = "hx";
        variables.EDITOR = "hx";
      };
      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    }

    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = {
        home = {
          inherit username;
          homeDirectory = "/home/${username}";
          stateVersion = "23.05";
        };

        imports = [
          ../../common/packages.nix
          ../../common/dotfiles
          ./packages.nix
          ./dotfiles
          # ./config
        ];
      };
    }
  ];
}
