{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = "24.05";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.gnome.gnome-keyring.enable = true;

  environment = {
    pathsToLink = [ "/libexec" ];
    systemPackages = [
      pkgs.gh
      pkgs.glab
    ];

    variables.SUDO_EDITOR = "hx";
    variables.EDITOR = "hx";
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    # opentabletdriver = {
    #   enable = true;
    # };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Monaspace" ]; }) ];
  fonts.packages = [
    # pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.monaspace
  ];

  # services.fwupd.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.dconf.enable = true;

  services.udisks2.enable = true;
  services.gvfs = {
    enable = true;
    package = pkgs.lib.mkForce pkgs.gnome.gvfs;
  };

  environment.localBinInPath = true;
  networking.nameservers = [ "192.168.178.1" ];

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
