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

    mod.nixosModules.home-manager
    mod.nixosModules.chaotic
  ];

  # services.fwupd.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirt" ];
  };

  nix.settings.trusted-users = [ username ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak.enable = true;
  services.ratbagd.enable = true;
  # chaotic.mesa-git.enable = true;

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

      dotfiles = {
        hyprland.extraConfig = # bash
          ''
            monitor=DP-2,2560x1440@170,1080x480,1
            monitor=DP-3,1920x1080@144,3640x840,1
            monitor=HDMI-A-1,1920x1080@60,0x0,1,transform,1
            workspace=name:Main, monitor:DP-2, default:true
            workspace=name:Second, monitor:DP-3, default:true
            workspace=name:Chat, monitor:HDMI-A-1, default:true, layoutopt:orientation:top
            exec-once=webcord
            exec-once=chatterino
          '';

        waybar.extraConfig = # bash
          ''
            "output": [ "DP-2" ],
            "modules-left": [
              "hyprland/workspaces",
              "hyprland/mode"
            ],
            "modules-center": [
              "clock#time",
            ],
            "modules-right": [
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
