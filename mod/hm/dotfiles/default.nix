{ pkgs, ... }:
let

  helix = import ./helix.nix;
  rofi = import ./rofi.nix;
  waybar = import ./waybar.nix;
  kitty = import ./kitty.nix;
  hyprland = import ./hyprland.nix;
  swayidle = import ./swayidle.nix;
  zathura = import ./zathura.nix;
in {
  options."dotfiles" = with pkgs.lib; {
    hyprland = {
      extraConfig = mkOption {
        type = types.str;
        default = "";
      };
    };
    waybar = {
      extraConfig = mkOption {
        type = types.str;
        default = "";
      };
    };
  };

  imports = [ helix rofi waybar kitty hyprland swayidle zathura ];
}
