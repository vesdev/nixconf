{
  pkgs,
  mod,
  host,
  home-manager,
  ...
}:
let
  username = "ves";
in
{
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
    extraGroups = [
      "wheel"
      "docker"
      "video"
    ];
    initialPassword = username;
  };
  nix.settings.trusted-users = [ username ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.logind.lidSwitch = "lock";
  services.udev.packages = [ pkgs.qmk-udev-rules ];
  programs.wireshark.enable = true;

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
        stateVersion = "23.05";
      };

      imports = with mod.hm; [
        dotfiles
        gtk
        xdg
        common-pkgs
        ./packages.nix
      ];

      dotfiles = {
        hyprland.extraConfig = # bash
          ''
            monitor=eDP-1,1920x1080@60,0x0,1
            workspace=name:Main, monitor:eDP-1, default:true
            windowrulev2 = workspace name:Chat, class:^(chromium-browser)
            exec-once=chromium
          '';

        waybar.extraConfig = # bash
          ''
            "output": [ "eDP-1" ],

            "modules-left": [
                "hyprland/workspaces",
                "hyprland/mode"
            ],
            "modules-center": [
            ],
            "modules-right": [
                "clock#time",
                "pulseaudio",
                "network",
                "memory",
                "cpu",
                "temperature",
                "battery",
                "tray",
                "clock#date",
            ],
          '';
      };
    };
  };
}
