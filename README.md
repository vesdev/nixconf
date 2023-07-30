# nixos_config

- git clone "https://github.com/vesdev/nixos_config"
- cd nixos_config
- cp /etc/nixos/hardware-configuration.nix ./hardware/hardware-configuration nix
- remove ./pcie-pass.nix from hardware/default.nix, or edit it if you want gpu passthrough
- edit user config home/<user>
- osu-stable has a long compile time so if you dont play osu, remove it from packages.nix
- edit system.nix with correct timezone etc..
- if youre not on uefi bios, change bootloader to grub
- nixos-rebuild switch --flake .
