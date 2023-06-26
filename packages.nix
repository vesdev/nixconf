{ config, pkgs, nix-gaming, pagbar, ... }: 
{
  home.packages = with pkgs; [
    # cli
    gh
    neofetch
    jq

    # deps
    libinput
    nodePackages_latest.pnpm
    linuxPackages_latest.perf

    # --apps--
    
      # system
      pcmanfm
      xarchiver
      pavucontrol
      flameshot
      mpv
      rofi
      feh
      alacritty
      pagbar.packages.${hostPlatform.system}.default

      # user
      librewolf
      krita
      inkscape
      discord-canary
      chatterino2
      mullvad-vpn
      obs-studio
      nix-gaming.packages.${hostPlatform.system}.osu-stable
    
      # dev
      helix
      vscodium

    # -------
  ];

  programs = {
    home-manager.enable = true;
    git.enable = true;

    bash.shellAliases = {
      nd = "nix develop";
    };
  };
}