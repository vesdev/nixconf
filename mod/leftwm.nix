{ pkgs, leftwm, ... }:
let
  package = leftwm.packages.${pkgs.system}.leftwm;
in {
  services = {
    
    xserver = {
      enable = true;

      layout = "de(us)";
      deviceSection = ''
        Option "TearFree" "true"
        Option "EnablePageFlip" "off"
      '';

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        # mouse.accelSpeed = "4.0";
      };

      desktopManager.xterm.enable = false;
      displayManager.sddm.enable = true;
      windowManager.leftwm = {
        enable = true;
        inherit package;
      };
    };

  }; 

}
