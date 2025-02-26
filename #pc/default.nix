{ config
, pkgs
, mod
, host
, home-manager
, ...
}:
let
  username = "ves";
in
{
  imports = with mod.nixos; [
    ./hardware-configuration.nix
    ./pcie-pass.nix
    ./services.nix

    common
    gaming
    network
    pipewire
    hyprland

    mod.nixosModules.home-manager
  ];

  networking.firewall =
    {
      enable = true;
      allowedTCPPorts = [ 6969 ];
    };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirt"
      "audio"
    ];
  };

  nix.settings.trusted-users = [ username ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  home-manager = {
    extraSpecialArgs = {
      inherit mod host;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "23.11";
      };

      imports = with mod.hm; [
        dotfiles
        gtk
        xdg
        shell
        common-pkgs
        ./packages.nix
        ./dotfiles.nix
      ];

    };
  };
}
