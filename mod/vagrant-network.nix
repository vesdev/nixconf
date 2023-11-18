{
  # Minimal configuration for NFS support with Vagrant.
  services.nfs.server.enable = true;
  
  # Add firewall exception for VirtualBox provider 
  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

  # Add firewall exception for libvirt provider when using NFSv4 
  networking.firewall.interfaces."virbr1" = {                                   
    allowedTCPPorts = [ 2049 ];                                               
    allowedUDPPorts = [ 2049 ];                                               
  }; 

  environment.etc = {
    "vbox/networks.conf".text = ''
      * 10.0.0.0/8 192.168.0.0/16
      * 2001::/64
    '';
  };  
}
