{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    joshuto.url = "github:kamiyaa/joshuto";
    polybar.url = "./common/polybar";
  };
 
  outputs = { self, nixpkgs, home-manager, nix-gaming, leftwm, joshuto, polybar, ...}:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system; 
      config.allowUnfree = true; 
      } // {      
      leftwm = leftwm.packages.${system}.leftwm;
      polybar = polybar.packages.${system}.polybar;
      joshuto = joshuto.packages.${system}.default;
      osu-stable = nix-gaming.packages.${system}.osu-stable;
      osu-lazer-bin = nix-gaming.packages.${system}.osu-lazer-bin;
    };

    commonArgs = {
        inherit system pkgs;
        specialArgs = {inherit home-manager nix-gaming;};
    };
  in {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem (commonArgs // {
        modules = [ 
          ./global.nix 
          ./pc 
        ];
      });
      laptop = nixpkgs.lib.nixosSystem ( commonArgs // {
        modules = [ ./global.nix ./laptop ];
      });  
    };
  };
}
