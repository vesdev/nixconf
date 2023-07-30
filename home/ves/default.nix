{ config, pkgs, pagbar, nix-gaming, ...}:
let
  username = "ves"; 
in {
  imports = [
    {users.users.${username} = {
      isNormalUser = true;
      home = "/home/${username}";
      extraGroups = [ "wheel" "docker" ]; 
      initialPassword = username;
      shell = pkgs.nushell;
    };}

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
}
