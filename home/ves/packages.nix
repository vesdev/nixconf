{ config, pkgs, ... }: 
{
  home.packages = with pkgs; [
    # cli
    gh
    neofetch
    jq
    bottom
    joshuto

    # deps
    libinput
    nodePackages_latest.pnpm
    linuxPackages_latest.perf
    openjdk
    pamixer
    pulseaudio
    
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
      polybar
      arandr
      
      # user
      librewolf
      krita
      handbrake
      # inkscape
      discord-canary
      chatterino2
      mullvad-vpn
      obs-studio
      osu-stable
      osu-lazer-bin

      # dev
      helix
      # vscodium

    # -------
  ];

  programs = {
    home-manager.enable = true;
    starship.enable = true;
    starship.enableBashIntegration = true;
    bash = {
      enable = true;
      shellAliases = {
        nd = "nix develop";
        jh = "joshuto";
      };
      # configFile.text = ''
      #   $env.config = {
      #     show_banner: false,
      #   }
      # '';
    };

    bash.enableCompletion = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}