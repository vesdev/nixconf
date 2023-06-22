{ config, pkgs, nix-gaming, leftwm, ... }: {

  system.stateVersion = "22.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  imports = [
    ./hardware-configuration.nix
    ./pci-passthrough.nix
    ./packages.nix
    "${nix-gaming}/modules/pipewireLowLatency.nix"
  ];
    
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  
  users.users.ves = {
    isNormalUser = true;
    home = "/home/ves";
    extraGroups = [ "wheel" "docker" ]; 
    initialPassword = "ves";
  };
  
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireguard.enable = true;
  };
  
  services = {
    mullvad-vpn.enable = true;
    openssh.enable = true;
  };
 
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  virtualisation.docker.enable = true;
  environment.variables.SUDO_EDITOR = "hx";
    
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opentabletdriver.enable = true;
  }; 

  programs = {
    git.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    bash.shellAliases.nd = "nix develop";
  };

  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;

    deviceSection = ''
      Option "TearFree" "false"
    '';

    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    windowManager.leftwm. enable = true;
  }; 
  
  sound.enable = true; 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    lowLatency = {
      enable = true;
      quantum = 128; # tweak for less latency, too low will crackle
      rate = 48000;
    };  
  }; 
  
  xdg.mime.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
  };
}
