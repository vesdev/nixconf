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
    joshuto.url = "github:kamiyaa/joshuto";
  };
 
  outputs = { self, nixpkgs, home-manager, nix-gaming, pagbar, leftwm, joshuto, ...}:
  let
    system = "x86_64-linux";
    username = "ves";
  in{
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit username nix-gaming home-manager;};
      modules = [
        {nixpkgs.overlays = [
          leftwm.overlay
          joshuto.overlays.default
        ];}
       
        ./system.nix
      ];
    };
  };
}
