{ pkgs, ... }:
{
  services = {
    mullvad-vpn.enable = true;
    openssh.enable = true;
  };
  
  networking = {
    wireless.iwd.enable = true;
    wireguard.enable = true;
  };
}
