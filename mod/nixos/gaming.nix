{ pkgs, mod, ... }:
{

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  environment.systemPackages = [
    pkgs.mangohud
    # pkgs.protonup-qt
  ];

  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  # audio
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
  ];

  users.users.ves.extraGroups = [ "audio" "rtkit" ];
  security.rtkit.enable = true;

  # other opts
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

  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = with pkgs; pkgs.steam.override {
        extraLibraries = pkgs: [ pipewire.jack ];
        extraPkgs = pkgs: [ wineasio ];

      };
    };
  };

  #disable smoothing for otd artist mode
  environment.etc = {
    "libinput/local-overrides.quirks".text = # ini
      ''
        [OpenTabletDriver Virtual Tablets]
        MatchName=OpenTabletDriver*
        AttrTabletSmoothing=0
      '';
  };
}
