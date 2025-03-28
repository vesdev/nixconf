# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, mod
, pkgs
, modulesPath
, ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-amd"
    "v4l2loopback"
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=3,4 exclusive_caps=1,1 card_label="Virtual Camera","Virtual Camera 2"
  '';

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/991c3074-f8bc-4ba0-85e4-4995a225d8cb";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."encrypted".device = "/dev/disk/by-uuid/9b7ecbec-580b-4b32-b6e2-466e35de9328";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9E60-449C";
    fsType = "vfat";
  };

  fileSystems."/media/HDD" = {
    device = "/dev/disk/by-uuid/229819DE9819B0F1";
    fsType = "ntfs";
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = false;
    open = false;
  };
  hardware.opengl.extraPackages = [
    pkgs.nvidia-vaapi-driver
  ];
  # hardware.opengl.package =
  #   pkgs.mesa.override { galliumDrivers = [ "radeonsi" "zink" "swrast" ]; };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.enableAllFirmware = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
