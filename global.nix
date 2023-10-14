{ config, pkgs, home-manager, ... }: 
{
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;    

  environment = {
    pathsToLink = [ "/libexec" ];
    systemPackages = [ pkgs.gh ];
  };
  
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opentabletdriver.enable = true;
  };
  
  security.rtkit.enable = true;  
  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  
  programs.git.enable = true;
}
