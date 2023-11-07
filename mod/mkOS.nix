{...}:
  { inputs, system, pkgs, mod, host }:
  let
    home-manager = inputs.home-manager;
  in {
    nixosConfigurations =
      builtins.mapAttrs (name: value: inputs.nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit home-manager mod;
            host = name;
          };
          modules = value; 
        }
      ) host;
  }

