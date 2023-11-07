{ pkgs, ... }:
{
  services = {
    mullvad-vpn.enable = true;
    openssh.enable = true;
  };
  
  networking = {
    hostName = "nixos";
    wireless.iwd.enable = true;
    wireguard.enable = true;
  };
}
