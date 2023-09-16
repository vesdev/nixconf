{
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
        mouse.accelSpeed = "4.0";
      };

      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = true;
      windowManager.leftwm.enable = true;
    };

  }; 
}
