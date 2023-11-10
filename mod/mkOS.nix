{ mod, nixpkgs, home-manager, pkgs, ... }: { modules }:
  {
    nixosConfigurations =
      builtins.mapAttrs (name: value: nixpkgs.lib.nixosSystem {
          inherit pkgs;
          system = pkgs.system;

          specialArgs = {
            inherit home-manager mod;
            host = name;
          };

          modules = value ++ [ ../+${name} ]; 
        }
      ) modules;
  }

