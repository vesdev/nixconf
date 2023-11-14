{ pkgs, home-manager, ... }: 
{
  system.stateVersion = "23.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;    

  environment = {
    pathsToLink = [ "/libexec" ];
    systemPackages = [ pkgs.gh pkgs.glab ];
  };
  
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opentabletdriver = {
      enable = true;
    };
  };
  
  security.rtkit.enable = true;  
  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  
  programs.git.enable = true;
  programs.dconf.enable = true;

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
