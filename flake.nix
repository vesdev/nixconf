{
  description = "ves anixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    pagbar.url = "github:vesdev/pagbar";
    helix.url = "github:helix-editor/helix";
    nix-ld = {
      url = "github:Mic92/nix-ld";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
 
  outputs = { self, nixpkgs, home-manager, nix-gaming, pagbar, leftwm, nix-ld, ...}:
  let
    system = "x86_64-linux";
    username = "ves";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [
        leftwm.overlay
      ];
    };
  in{
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      #for pipewrite low latency in configuration.nix
      specialArgs = {inherit username nix-gaming nix-ld;};
      modules = [ 
        ./system.nix
        ./system-packages.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ves = {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
              stateVersion = "23.05";
            };

            imports = [
              ./config
              ./packages.nix
            ];
          };
          home-manager.extraSpecialArgs = {inherit nix-gaming pagbar;};
        }
      ];
    };
  };

}
