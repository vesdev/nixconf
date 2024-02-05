{ pkgs, mod, host, home-manager, ... }:
let username = "ves";
in {

  imports = with mod.nixos; [
    ./hardware-configuration.nix
    ./pcie-pass.nix

    common
    gaming
    network
    hyprland
    pipewire

    home-manager.nixosModules.home-manager
  ];

  # services.fwupd.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirt" ];
  };

  nix.settings.trusted-users = [ username ];

  home-manager = {
    extraSpecialArgs = { inherit mod host; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "23.11";
      };

      imports = with mod.hm; [ dotfiles gtk xdg common-pkgs ./packages.nix ];
    };
  };

  # services.udev.packages = [ pkgs.qmk-udev-rules ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak.enable = true;
}
