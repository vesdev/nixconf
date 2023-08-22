{ config, pkgs, ... }:
let
  shellAliases = {
    nd = "nix develop";
    jh = "joshuto";
  };
in {
  home.packages = with pkgs; [
    # cli
    gh
    neofetch
    jq
    bottom
    joshuto 
    qmk
    
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
    starship.enableNushellIntegration = true;
    nushell = {
      enable = true;
      inherit shellAliases;
      configFile.text = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };

    bash = {
      enable = true;
      inherit shellAliases;
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}