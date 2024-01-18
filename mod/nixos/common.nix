{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = "24.05";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment = {
    pathsToLink = [ "/libexec" ];
    systemPackages = [ pkgs.gh pkgs.glab ];

    variables.SUDO_EDITOR = "hx";
    variables.EDITOR = "hx";
  };

  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opentabletdriver = { enable = true; };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; }) ];

  # services.fwupd.enable = true;
  programs.git.enable = true;
  programs.dconf.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

}
