{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    joshuto.url = "github:kamiyaa/joshuto";
    hyprland.url = "github:hyprwm/Hyprland";
  };
 
  outputs = inputs@{...}:
  let  
    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs { 
      inherit system; 
      config.allowUnfree = true;
    };

    mod = import ./mod {inherit inputs pkgs;};

  in with mod; mod.mkOS {
    inherit inputs system pkgs mod;

    host.pc = [
      core
      gaming
      network
      hyprland
      pipewire

      ./pc 
    ];

    # TODO: update laptop config
    # host.laptop = [
    #   core
    #   gaming
    #   network
    #   hyprland
    #   pipewire

    #   ./laptop 
    # ];    
  };
}
