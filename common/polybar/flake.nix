{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
        packages.x86_64-linux = rec {
          polybar = pkgs.stdenv.mkDerivation rec {
            pname = "polybar";
            version = "3.6.3";
            src = pkgs.fetchFromGitHub {
              owner = pname;
              repo = pname;
              rev = "1bfe117c5d91c7312d9dee12bc83e4aca34c995e";
              hash = "sha256-4BJ8s68KOA+eF4P/JafXqwVDl1/vsIfbvufSncsLXwk=";
              fetchSubmodules = true;
            };

            buildInputs = with pkgs; [
              alsaLib
              cairo.dev
              cmake
              curl.dev
              i3
              jsoncpp.dev
              libmpdclient
              libpulseaudio
              libuv
              pkg-config
              sphinx
              wirelesstools
              xorg.libxcb
              xorg.xcbproto
              xorg.xcbutilimage
              xorg.xcbutilwm.dev
            ];
          };
          default = polybar;
        };
    };
}
