{ config, pkgs, myPkgs, ... }:
let
  shellAliases = {
    nd = "nix develop";
    nl = "echo $SHLVL";
    ngc = "sudo nix-collect-gargbage -d";
    # jh = "joshuto";
    lg = "lazygit";
    switch = "sudo nixos-rebuild switch --flake";
  };
in {
  home.packages = with pkgs; [
    # cli
    gh
    neofetch
    jq
    bottom
    lazygit
    appimage-run
    
    # deps
    libinput
    nodePackages_latest.pnpm
    linuxPackages_latest.perf
    openjdk
    pamixer
    pulseaudio
    cava
    
    # --apps--
    
      # system
      xfce.thunar
      xarchiver
      pavucontrol
      flameshot
      mpv
      rofi
      feh
      alacritty
      myPkgs.polybar
      arandr
      
      # user
      librewolf
      discord
      chatterino2
      mullvad-vpn

      # dev
      helix

    # -------
  ];

  programs = {
    home-manager.enable = true;
    # starship.enable = true;
    # starship.enableNushellIntegration = true;
    # nushell = {
    #   enable = true;
    #   inherit shellAliases;
    #   configFile.text = ''
    #     $env.config = {
    #       show_banner: false,
    #     }
    #   '';
    # };

    bash = {
      enable = true;
      inherit shellAliases;
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
