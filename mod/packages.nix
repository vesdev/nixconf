{ mod , pkgs, ... }: { host, ... }:
  let
    shellAliases = {
      nd = "nix develop";
      nl = "echo $SHLVL";
      ngc = "sudo nix-collect-garbage -d";
      lg = "lazygit";
      ls = "eza";
      switch = "sudo nixos-rebuild switch --flake .#${host}";
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
      eza
      sshfs
      ripgrep
      zellij
    
      # deps
      libinput
      nodePackages_latest.pnpm
      linuxPackages_latest.perf
      openjdk
      pamixer
      pulseaudio
      cava
      nixfmt
    
      # --apps--
    
        # system
        xfce.thunar
        xarchiver
        pavucontrol
        flameshot
        mpv
        feh
        alacritty
        mod.polybar
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

      bash = {
        enable = true;
        inherit shellAliases;
      };

      direnv.enable = true;
      direnv.nix-direnv.enable = true;
    };
  }
