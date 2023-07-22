{ config, pkgs, username, nix-gaming, ... }: 
{
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ./pcie-pass.nix
    "${nix-gaming}/modules/pipewireLowLatency.nix"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];  
  powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" "docker" ]; 
    initialPassword = username;
    shell = pkgs.nushell;
  };
    
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
 
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  environment = {
    variables.SUDO_EDITOR = "hx";
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

  fonts.fonts = with pkgs; [
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
    
    xserver = {
      enable = true;

      deviceSection = ''
        Option "TearFree" "true"
      '';

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
        quantum = 48; # tweak for less latency, too low will crackle
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
