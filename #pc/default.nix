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
    niri
    # hyprland

    mod.nixosModules.home-manager
    mod.nixosModules.chaotic
  ];

  chaotic.mesa-git.enable = true;

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

  networking.extraHosts = ''
    192.168.178.81 navi
    167.235.241.82  www.growtopia1.com
    167.235.241.82  www.growtopia2.com
    167.235.241.82  growtopia1.com
    167.235.241.82  growtopia2.com
  '';

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
