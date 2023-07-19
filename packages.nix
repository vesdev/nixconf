{ config, pkgs, nix-gaming, pagbar, ... }: 
{
  home.packages = with pkgs; [
    # cli
    gh
    neofetch
    jq
    bottom

    # deps
    libinput
    nodePackages_latest.pnpm
    linuxPackages_latest.perf
    openjdk
    
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
      arandr
      
      # user
      librewolf
      krita
      # inkscape
      discord-canary
      # chatterino2
      mullvad-vpn
      obs-studio
      # nix-gaming.packages.${hostPlatform.system}.wine-discord-ipc-bridge
      # nix-gaming.packages.${hostPlatform.system}.wine-osu
      nix-gaming.packages.${hostPlatform.system}.osu-stable
    
      # dev
      helix
      # vscodium

    # -------
  ];

  programs = {
    home-manager.enable = true;
    starship.enable = true;
    starship.enableNushellIntegration = true;
    nushell = {
      enable = true;
      shellAliases = {
        nd = "nix develop";
      };
      configFile.text = ''
        let-env config = {
          show_banner: false,
        }
      '';
    };
  };
}