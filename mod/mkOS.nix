{ mod, nixpkgs, home-manager, pkgs, ... }:
hosts: {
  nixosConfigurations = builtins.listToAttrs (builtins.map (name: {
    inherit name;
    value = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      system = pkgs.system;

      specialArgs = {
        inherit home-manager mod;
        host = name;
      };

      modules =
        [ ../${"#" + name} { networking = { hostName = "nixos-${name}"; }; } ];
    };

  }) hosts);
}

