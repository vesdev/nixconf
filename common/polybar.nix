{ config
, cairo
, cmake
, fetchFromGitHub
, libuv
, libXdmcp
, libpthreadstubs
, libxcb
, pcre
, pkg-config
, python3
, python3Packages # sphinx-build
, lib
, stdenv
, xcbproto
, xcbutil
, xcbutilcursor
, xcbutilimage
, xcbutilrenderutil
, xcbutilwm
, xcbutilxrm
, makeWrapper
, removeReferencesTo
, alsa-lib
, curl
, libmpdclient
, libpulseaudio
, wirelesstools
, libnl
, i3
, jsoncpp

  # override the variables ending in 'Support' to enable or disable modules
, alsaSupport ? true
, githubSupport ? false
, mpdSupport ? false
, pulseSupport ? config.pulseaudio or false
, iwSupport ? false
, nlSupport ? true
, i3Support ? false
}:

stdenv.mkDerivation rec {
  pname = "polybar";
  version = "3.6.3";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "1bfe117c5d91c7312d9dee12bc83e4aca34c995e";
    hash = "sha256-4BJ8s68KOA+eF4P/JafXqwVDl1/vsIfbvufSncsLXwk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    python3Packages.sphinx
    removeReferencesTo
  ] ++ lib.optional i3Support makeWrapper;

  buildInputs = [
    cairo
    libuv
    libXdmcp
    libpthreadstubs
    libxcb
    pcre
    python3
    xcbproto
    xcbutil
    xcbutilcursor
    xcbutilimage
    xcbutilrenderutil
    xcbutilwm
    xcbutilxrm
  ] ++ lib.optional alsaSupport alsa-lib
  ++ lib.optional githubSupport curl
  ++ lib.optional mpdSupport libmpdclient
  ++ lib.optional pulseSupport libpulseaudio
  ++ lib.optional iwSupport wirelesstools
  ++ lib.optional nlSupport libnl
  ++ lib.optionals i3Support [ jsoncpp i3 ];

  # patches = [ ./remove-hardcoded-etc.diff ];

  # Replace hardcoded /etc when copying and reading the default config.
  # postPatch = ''
  #   substituteInPlace CMakeLists.txt --replace "/etc" $out
  #   substituteAllInPlace src/utils/file.cpp
  # '';

  # postInstall =
  #   lib.optionalString i3Support ''
  #     wrapProgram $out/bin/polybar \
  #       --prefix PATH : "${i3}/bin"
  #   '';

  postFixup = ''
    remove-references-to -t ${stdenv.cc} $out/bin/polybar
  '';
}
