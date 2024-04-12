{ pkgs, ... }:
let
  username = "ves";
in
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ username ];

  networking.extraHosts = ''
    192.168.33.16 makupalat.fi.local www.makupalat.fi.local
    192.168.33.12 frontend.kirjasampo.fi.local www.frontend.kirjasampo.fi.local
    192.168.33.12 kirjasampo.fi.local www.kirjasampo.fi.local
  '';

  environment.etc = {
    "vbox/networks.conf".text = ''
      * 10.0.0.0/8 192.168.0.0/16
      * 2001::/64
    '';
  };
}
