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
    helix.url = "github:helix-editor/helix";

  };
 
  outputs = { self, nixpkgs, home-manager, nix-gaming, pagbar, leftwm, ...}:
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
      specialArgs = {inherit username nix-gaming home-manager;};
      modules = [ 
        ./system.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {
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
