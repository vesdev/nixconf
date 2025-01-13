{ inputs, hosts }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "fluffychat-linux-1.22.1"
      "olm-3.2.16"
      "openssl-1.1.1w"
    ];
  };

  mod = {
    pkgs = import ./pkgs { inherit inputs hosts pkgs; };
    nixosModules = {
      pipewire = inputs.nix-gaming.nixosModules.pipewireLowLatency;
      home-manager = inputs.home-manager.nixosModules.home-manager;
    };
  };

  modArgs = { inherit pkgs mod; };
  mod."nixos" = import ./nixos { inherit modArgs; };
  mod."hm" = import ./hm { inherit modArgs; };
in
with inputs; (
  import ./hosts.nix
  {
    inherit
      nixpkgs
      home-manager
      mod
      pkgs;
  }
    hosts
)
