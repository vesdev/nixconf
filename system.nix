{ config, pkgs, home-manager, ... }: 
{
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware
    ./home
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];  
  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
    
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
 
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];

    trusted-users = [ "ves" ];
  };

  environment = {
    variables.SUDO_EDITOR = "hx";
    variables.EDITOR = "hx";
    shells = [ pkgs.nushell ];
  };
    
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opentabletdriver.enable = true;
  };

  environment.pathsToLink = [ "/libexec" ];
  
  sound.enable = true; 
  security.rtkit.enable = true;  

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireguard.enable = true;
  };
  
  virtualisation.docker.enable = true;
  
  environment.systemPackages = [
    pkgs.gh
  ];

  programs = {
    git.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  services = {
    mullvad-vpn.enable = true;
    openssh.enable = true;

    udev.packages = [
      pkgs.qmk-udev-rules
    ];
    
    xserver = {
      enable = true;

      deviceSection = ''
        Option "TearFree" "true"
        Option "EnablePageFlip" "off"
      '';

      layout = "de(us)";

      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "4.0";
        };
      };

      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = true;
      windowManager.leftwm.enable = true;
    };
     
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    
      lowLatency = {
        enable = true;
        quantum = 256; # tweak for less latency, too low will crackle
        rate = 48000;
      };  
    }; 
  };

  xdg.mime.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
  };

}
