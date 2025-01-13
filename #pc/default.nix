{ pkgs
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

    common
    gaming
    network
    # hyprland
    pipewire
    hyprland

    # mod.nixosModules.vuekobot
    mod.nixosModules.home-manager
  ];

  networking.firewall =
    {
      enable = true;
      allowedTCPPorts = [ 6969 ];
    };

  # musnix = {
  #   enable = true;
  #   kernel.realtime = true;
  #   # kernel.optimize = true;
  #   rtirq.enable = true;
  # };

  # services.fwupd.enable = true;
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
  services.flatpak.enable = true;
  services.ratbagd.enable = true;

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   stdenv.cc.cc.lib
  #   icu
  #   openssl
  #   mono
  #   SDL2
  # ];

  services.postgresql = {
    enable = true;
    # ensureDatabases = [ "byteracer" "vueko" ];
    authentication = ''
      local all       postgres     trust
    '';
    identMap = ''
      superuser_map      ves      postgres
    '';
  };

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
      ];

      dotfiles = {
        hyprland.extraConfig = # bash
          ''
            monitor=DP-2,1920x1080@144,0x840,1
            monitor=DP-3,2560x1440@170,1920x480,1
            monitor=HDMI-A-1,1920x1080@60,4480x0,1,transform,1
            workspace=name:Main, monitor:DP-3, default:true
            workspace=name:Second, monitor:DP-2, default:true
            workspace=name:Chat, monitor:HDMI-A-1, default:true, layoutopt:orientation:left, layoutopt:new_is_master:true
            exec-once=vesktop
            exec-once=chatterino
            exec-once=fluffychat
          '';

        waybar.extraConfig = # bash
          ''
            "output": [ "DP-3" ],
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
