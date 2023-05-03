# Edit this configuration file to define what should be installed on
{ config, pkgs, nix-gaming, ... }: {
  system.stateVersion = "22.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  
  nixpkgs.config.allowUnfree = true;
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${nix-gaming}/modules/pipewireLowLatency.nix"
    ]; 

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
 
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cachix
    wine
    gh
  ];

  services.openssh.enable = true;
  
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
  };

  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;

    deviceSection = ''
      Option "TearFree" "false"
    '';

    desktopManager = {
      xterm.enable = false;
    };

    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        polybar
        feh
        alacritty
        pavucontrol
        arandr
      ];
    };

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
      quantum = 256; # tweak for less latency, too low will crackle
      rate = 48000;
    };  
  };
  
  users.users.ves = {
    isNormalUser = true;
    home = "/home/ves";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      neofetch
      vscodium
      nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable
    ];
    initialPassword = "ves";
  };

}

