{
  description = "ves nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-gaming.url = "github:fufexan/nix-gaming";
    leftwm.url = "github:leftwm/leftwm";
    eza.url = "github:eza-community/eza";
    hyprland.url = "github:hyprwm/Hyprland";
  };
 
  outputs = inputs:
  let  
    pkgs = import inputs.nixpkgs { 
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in with import ./mod {inherit inputs pkgs;}; mkOS {
    pc = [
      core
      gaming
      network
      hyprland
      pipewire
    ];

    laptop = [
      core
      gaming
      network
      hyprland
      pipewire
    ];    
  };
}
