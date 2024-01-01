{ config, pkgs, mod, host, home-manager, ... }:
let username = "ves";
in {

  imports = with mod.nixos; [

    ./hardware-configuration.nix
    ./pcie-pass.nix
    core
    gaming
    network
    hyprland
    pipewire
    # agenix

    {
      # age.secrets.secret-patch = {

      #   file = ../secrets/secret-patch.age;

      #   symlink = false;
      # };

      networking.extraHosts = ''
        192.168.33.16 makupalat.fi.local www.makupalat.fi.local
      '';

      services.fwupd.enable = true;
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
        initialPassword = username;
      };

      nix.settings.trusted-users = [ username ];

      services.udev.packages = [ pkgs.qmk-udev-rules ];
      environment = {
        variables.SUDO_EDITOR = "hx";
        variables.EDITOR = "hx";
      };

      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      services.flatpak.enable = true;
    }

    home-manager.nixosModules.home-manager
    {
      home-manager.extraSpecialArgs = { inherit mod host; };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = {
        home = {
          inherit username;
          homeDirectory = "/home/${username}";
          stateVersion = "23.05";

          # packages = [
          #   (pkgs.callPackage bitwig-studio {
          #     wideHardo = config.age.secrets.secret-patch.path;
          #   })
          # ];
        };

        imports = with mod.hm; [
          dotfiles gtk common-pkgs
          ./packages.nix ./dotfiles 
          xdg 
        ];
      };
    }

  ];
}
