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

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };
}
