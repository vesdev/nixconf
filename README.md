# nixos_config

the config is tructured like this:
modules are stored in mod/
to easily share common behaviour across systems
system profiles start with the +prefix

├── flake.nix
├── mod
│   ├── default.nix
│   modules ...
├── +laptop
└── +pc
