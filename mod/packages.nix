{ mod , pkgs, ... }: { host, ... }:
  let
    shellAliases = {
      nd = "nix develop";
      nl = "echo $SHLVL";
      ngc = "sudo nix-collect-garbage -d";
      lg = "lazygit";
      ls = "eza";
      switch = "sudo nixos-rebuild switch --flake .#${host}";
      cat = "bat";
      rg = "batgrep";
    };
  in {
    home.packages = with pkgs; [
      #not in use
      # mod.polybar
      # flameshot
      # zellij
      # cava
      
      # cli/tui
      gh
      neofetch
      jq
      bottom
      lazygit
      appimage-run
      eza
      sshfs
      ripgrep
      helix
      glow
      bat
      bat-extras.batgrep
      bat-extras.prettybat
    
      # deps
      libinput
      nodePackages_latest.pnpm
      linuxPackages_latest.perf
      openjdk
      pamixer
      pulseaudio
      nixfmt
      ltex-ls
      marksman
      xdg-utils
    
      # system
      xfce.thunar
      xarchiver
      pavucontrol
      mpv
      feh
      alacritty
      arandr
    
      # apps
      librewolf
      webcord-vencord
      # (pkgs.discord.override {
      #   # remove any overrides that you don't want
      #   withopenasar = true;
      #   withvencord = true;
      #   nss = nss_latest;
      # })
      chatterino2
      mullvad-vpn
    ];

    programs = {
      home-manager.enable = true;

      bash = {
        enable = true;
        inherit shellAliases;

        bashrcExtra = ''
          export MANPAGER="sh -c 'col -bx | bat -l man -p'"
        '';
      };

      direnv.enable = true;
      direnv.nix-direnv.enable = true;
    };
  }
