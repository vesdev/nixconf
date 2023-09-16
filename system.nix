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
    # shells = [ pkgs.nushell ];
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
    wireless.iwd.enable = true;
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

  systemd.tmpfiles.rules = [
    "w /proc/sys/vm/compaction_proactiveness - - - - 0"
    "w /proc/sys/vm/min_free_kbytes - - - - 1048576"
    "w /proc/sys/vm/swappiness - - - - 10"
    "w /sys/kernel/mm/lru_gen/enabled - - - - 5"
    "w /proc/sys/vm/zone_reclaim_mode - - - - 0"
    "w /sys/kernel/mm/transparent_hugepage/enabled - - - - never"
    "w /sys/kernel/mm/transparent_hugepage/shmem_enabled - - - - never"
    "w /sys/kernel/mm/transparent_hugepage/khugepaged/defrag - - - - 0"
    "w /proc/sys/vm/page_lock_unfairness - - - - 1"
    "w /proc/sys/kernel/sched_child_runs_first - - - - 0"
    "w /proc/sys/kernel/sched_autogroup_enabled - - - - 1"
    "w /proc/sys/kernel/sched_cfs_bandwidth_slice_us - - - - 500"
    "w /sys/kernel/debug/sched/latency_ns  - - - - 1000000"
    "w /sys/kernel/debug/sched/migration_cost_ns - - - - 500000"
    "w /sys/kernel/debug/sched/min_granularity_ns - - - - 500000"
    "w /sys/kernel/debug/sched/wakeup_granularity_ns  - - - - 0"
    "w /sys/kernel/debug/sched/nr_migrate - - - - 8"
  ];

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
        quantum = 64; # tweak for less latency, too low will crackle
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
