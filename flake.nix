{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    joshuto.url = "github:kamiyaa/joshuto";
    hyprland.url = "github:hyprwm/Hyprland";
  };
 
  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs { 
      inherit system; 
      config.allowUnfree = true;
    };

    xwayland = pkgs.xwayland.overrideAttrs (old: {
      patches = (old.patches or []) ++ [
        (pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/hyprwm/Hyprland/8e9f010ee0bae1989279925e8f214bb18c36ba2e/nix/patches/xwayland-vsync.patch";
          hash = "sha256-VjquNMHr+7oMvnFQJ0G0whk1/253lZK5oeyLPamitOw=";
        })
      ];
    });

    myPkgs = with inputs; {
      polybar = pkgs.callPackage ./common/polybar.nix {};
      joshuto = joshuto.packages.${system}.default;
      osu-stable = nix-gaming.packages.${system}.osu-stable;
      osu-lazer = nix-gaming.packages.${system}.osu-lazer-bin;
      leftwm = leftwm.packages.${system}.leftwm;
      hyprland = hyprland.packages.${system}.hyprland.override {
        inherit xwayland;  
        wlroots = hyprland.packages.${system}.wlroots-hyprland.override {
          wlroots = pkgs.wlroots.override { inherit xwayland; };
        };
      };
    };

    commonArgs = with inputs; {
        inherit system pkgs;
        specialArgs = {inherit home-manager nix-gaming myPkgs;};
    };
  in {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem (commonArgs // {
        modules = [ 
          ./common 
          ./pc 
        ];
      });
      laptop = nixpkgs.lib.nixosSystem ( commonArgs // {
        modules = [ 
          ./common 
          ./laptop 
        ];
      });  
    };
  };
}
