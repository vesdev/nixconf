{ pkgs, mod, host, home-manager, ... }:
let username = "ves";
in {
  imports = with mod.nixos; [

    ./hardware-configuration.nix
    ./virt.nix
    common
    gaming
    network
    hyprland
    pipewire

    home-manager.nixosModules.home-manager

  ];

  security.sudo.configFile = ''
    ves ALL=(ALL:ALL) NOPASSWD: ALL
  '';

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "video" ];
    initialPassword = username;
  };
  nix.settings.trusted-users = [ username ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.logind.lidSwitch = "lock";
  services.udev.packages = [ pkgs.qmk-udev-rules ];

  home-manager = {
    extraSpecialArgs = { inherit mod host; };

    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "23.05";
      };

      imports = with mod.hm; [
        dotfiles
        gtk
        xdg
        common-pkgs
        ./packages.nix
        ./dotfiles
      ];

    };
  };
}
