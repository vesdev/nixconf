{ config, pkgs, ... }:
let username = "ves"; # user for pcie pass
in {
  boot.kernelParams = [ "pcie_aspm=off" ];
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" ];

  boot.extraModprobeConfig =
    "options vfio-pci ids=10de:1f08,10de:10f9,10de:1ada,10de:1adb";
  # boot.extraModulePackages = [ pkgs.linuxPackages_xanmod_latest.kvmfr ];

  environment.systemPackages = with pkgs; [
    qemu
    OVMF
    dconf
    looking-glass-client
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  programs.virt-manager.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" "libvirt" ];

  systemd.tmpfiles.rules =
    [ "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -" ];

  # services.udev.extraRules = ''
  #   SUBSYSTEM=="kvmfr", OWNER="${username}", GROUP="kvm", MODE="0660"
  # '';

}
