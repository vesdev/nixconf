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

  networking.extraHosts = ''
    192.168.33.16 makupalat.fi.local www.makupalat.fi.local
  '';

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu.ovmf.enable = true;
  #   onBoot = "ignore";
  #   onShutdown = "shutdown";
  # };
  
  # users.groups.libvirtd.members = [ "root" username ];
  # users.users.${username}.extraGroups = [ "libvirtd" ];


}
