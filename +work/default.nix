{ pkgs, mod, host, home-manager, ... }:
let
  username = "ves"; 
in {
  imports = [

    ./hardware-configuration.nix

    {
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "video" ]; 
        initialPassword = username;
      };

      nix.settings.trusted-users = [ username ];

      xdg.mime.defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
      };

      environment = {
        variables.SUDO_EDITOR = "hx";
        variables.EDITOR = "hx";
      };
      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      services.logind.lidSwitch = "ignore";
    }

    home-manager.nixosModules.home-manager {
      home-manager.extraSpecialArgs = {inherit mod host;};

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = {
        home = {
          inherit username;
          homeDirectory = "/home/${username}";
          stateVersion = "23.05";
        };

        imports = with mod; [          
          dotfiles
          gtk
          packages
          ./packages.nix
          ./dotfiles
        ];
      };
    }

  ];
}
