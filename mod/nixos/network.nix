{ pkgs, mod, ... }:
{
  services = {
    mullvad-vpn.enable = true;
    mullvad-vpn.package = mod.pkgs.mullvad;
    openssh.enable = true;
  };

  networking = {
    wireless.iwd.enable = true;
    wireguard.enable = true;
  };
}
