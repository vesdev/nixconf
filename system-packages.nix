{ config, pkgs, nix-gaming, leftwm, nix-ld, ... }: 
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ./pcie-pass.nix
    "${nix-gaming}/modules/pipewireLowLatency.nix"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ 
      "initcall_blacklist=acpi_cpufreq_init"
      "amd_pstate=active"
      "amd_pstate.shared_mem=1" 
    ];
    kernelModules = [ "amd-pstate" ];
  };

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
