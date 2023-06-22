{
  inputs = {
    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    pagbar.url = "github:vesdev/pagbar";
    helix.url = "github:helix-editor/helix";
  }; 
 
  outputs = { self, nixpkgs, leftwm, ...}@attrs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [
        leftwm.overlay
      ];
    }; 
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = attrs;
      modules = [ 
        ./configuration.nix	
      ];    
    };
  };

}
