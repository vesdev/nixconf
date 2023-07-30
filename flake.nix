{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    pagbar.url = "github:vesdev/pagbar";
    joshuto.url = "github:kamiyaa/joshuto";
  };
 
  outputs = { self, nixpkgs, home-manager, nix-gaming, pagbar, leftwm, joshuto, ...}:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; } // {      
      leftwm = leftwm.packages.${system}.leftwm;
      joshuto = joshuto.packages.${system}.default;
      osu-stable = nix-gaming.packages.${system}.osu-stable;
      osu-lazer-bin = nix-gaming.packages.${system}.osu-lazer-bin;
      pagbar = pagbar.packages.${system}.default;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit home-manager;};
      modules = [
        "${nix-gaming}/modules/pipewireLowLatency.nix"
        ./system.nix
      ];
    };
  };
}
