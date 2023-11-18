{ pkgs, ... }:
let 
  username = "ves";
in
{
  virtualisation.virtualbox.host.enable = true;  
  users.extraGroups.vboxusers.members = [ username ];

  environment.systemPackages = with pkgs; [
    virt-manager
    # qemu
    # OVMF
    # dconf
  ];

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu.ovmf.enable = true;
  #   onBoot = "ignore";
  #   onShutdown = "shutdown";
  # };
  
  # users.groups.libvirtd.members = [ "root" username ];
  # users.users.${username}.extraGroups = [ "libvirtd" ];


}
