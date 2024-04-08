{ pkgs, mod, ... }: {

  # boot.kernelPackages = mod.pkgs.cachyos;
  # environment.systemPackages = [ mod.pkgs.scx ];

  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
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

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package =
        pkgs.steam.override { extraPkgs = pkgs: with pkgs; [ gamescope ]; };
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
