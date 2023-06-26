{ config, pkgs, username, ... }:
{  
  # CHANGE: intel_iommu enables iommu for intel CPUs with VT-d
  # use amd_iommu if you have an AMD CPU with AMD-Vi
  boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off"  ];
    
  # These modules are required for PCI passthrough, and must come before early modesetting stuff
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  
  # CHANGE: Don't forget to put your own PCI IDs here
  boot.extraModprobeConfig ="options vfio-pci ids=10de:1f08,10de:10f9,10de:1ada,10de:1adb";
  
  environment.systemPackages = with pkgs; [
    virtmanager
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
  
  # CHANGE: add your own user here
  users.groups.libvirtd.members = [ "root" username ];

  users.users.${username}.extraGroups = [ "libvirtd" ];
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -"
  ];

}
