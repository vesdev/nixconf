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

  # services.fwupd.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirt"
    ];
  };

  nix.settings.trusted-users = [ username ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak.enable = true;
  services.ratbagd.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    icu
    openssl
    mono
    SDL2
  ];

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

  # services.vueko-frontend = {
  #   enable = true;
  #   package = mod.pkgs.vueko-frontend;
  # };

  # services.vueko-backend = {
  #   enable = true;
  #   package = mod.pkgs.vueko-backend;
  #   configFile = "/home/ves/dev/vuekobot/vueko.toml";
  # };

  # chaotic.mesa-git.enable = true;

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
            monitor=DP-3,1920x1080@144,2560x1290,1
            monitor=DP-2,2560x1440@170,0x930,1
            monitor=HDMI-A-1,1920x1080@60,4480x450,1,transform,1
            workspace=name:Main, monitor:DP-3, default:true
            workspace=name:Second, monitor:DP-2, default:true
            workspace=name:Chat, monitor:HDMI-A-1, default:true, layoutopt:orientation:left, layoutopt:new_is_master:true
            exec-once=vesktop
            exec-once=chatterino
            exec-once=element-desktop
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
