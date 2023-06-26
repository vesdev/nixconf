{ config, pkgs, nix-gaming, pagbar, ... }: 
{
  home.packages = with pkgs; [
    gh
    pavucontrol
    helix
    alacritty
    feh
    polybar
    rofi
    libinput
    jq
    nodePackages_latest.pnpm
    linuxPackages_latest.perf
    librewolf
    neofetch
    vscodium
    mpv
    discord-canary
    pcmanfm
    xarchiver
    flameshot
    obs-studio
    mullvad-vpn
    krita
    inkscape
    pagbar.packages.${hostPlatform.system}.default
    godot_4
    chatterino2
    element-desktop
    nix-gaming.packages.${hostPlatform.system}.osu-stable
  ];

  programs = {
    home-manager.enable = true;
    git.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    bash.shellAliases.nd = "nix develop";
  };
}