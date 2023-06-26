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
  };
 
  outputs = { self, nixpkgs, home-manager, nix-gaming, pagbar, ...}:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #for pipewrite low latency in configuration.nix
      specialArgs = {inherit nix-gaming;};
      modules = [ 
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ves = {
            home = rec {
              username = "ves";
              homeDirectory = "/home/${username}";
              stateVersion = "23.05";
            };

            imports = [
              ./packages.nix
            ];
          };
          home-manager.extraSpecialArgs = {inherit nix-gaming pagbar;};
        }
      ];
    };
  };

}
