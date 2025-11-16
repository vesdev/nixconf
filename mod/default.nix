{ inputs, hosts }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "fluffychat-linux-1.22.1"
      "olm-3.2.16"
      "openssl-1.1.1w"
      "mbedtls-2.28.10"
    ];
    # overlays =
    #   let
    #     pinnedWine =
    #       import
    #         (fetchTarball {
    #           url = "https://github.com/NixOS/nixpkgs/archive/da466ad.tar.gz";
    #           sha256 = "04wc7l07f34aml0f75479rlgj85b7n7wy2mky1j8xyhadc2xjhv5";
    #         })
    #         {
    #           system = pkgs.system;
    #           config = { }; # Omit or add necessary config options if required
    #         };
    #   in
    #   [
    #     (self: super: {
    #       wineWowPackages = super.wineWowPackages // {
    #         staging = pinnedWine.wineWowPackages.staging;
    #         stagingFull = pinnedWine.wineWowPackages.staging;
    #       };

    #       yabridge = super.yabridge.override {
    #         wine = pinnedWine.wineWowPackages.staging;
    #       };

    #       yabridgectl = super.yabridgectl.override {
    #         wine = pinnedWine.wineWowPackages.staging;
    #       };
    #     })
    #   ];
  };

  mod = {
    pkgs = import ./pkgs { inherit inputs hosts pkgs; };
    nixosModules = {
      # pipewire = inputs.nix-gaming.nixosModules.pipewireLowLatency;
      home-manager = inputs.home-manager.nixosModules.home-manager;
      chaotic = inputs.chaotic.nixosModules.default;
      # rdt-client = inputs.rdt-client.nixosModules.rdt-client;
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
