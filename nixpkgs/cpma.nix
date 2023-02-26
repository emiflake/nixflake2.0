{ pkgs }:
# { lib
# , stdenv
# , fetchFromGitHub
# , makeWrapper
# , curl
# , libGL
# , libX11
# , libXxf86dga
# , alsa-lib
# , libXrandr
# , libXxf86vm
# , libXext
# , SDL2
# , glibc
# , quake3e
# , fetchzip
# , autoPatchelfHook
# }:

let
  q3-files = pkgs.fetchFromGitHub
    {
      owner = "nrempel";
      repo = "q3-server";
      rev = "ce4b9511d4bcf1333aa3ed0ebb5d791309859ca4";
      sha256 = "sha256-veM5a9V6leO5NxvZDfTl3OW3h7bl2u3vZw1za3/iOGA=";
    }
  ;

  inherit (pkgs) lib stdenv fetchFromGitHub makeWrapper curl libGL alsa-lib SDL2 glibc quake3e fetchzip autoPatchelfHook;
  inherit (pkgs.xorg) libX11 libXxf86dga libXrandr libXxf86vm libXext;

  version = "1.52";
  mod = fetchzip {
    url = "https://cdn.playmorepromode.com/files/cpma/cpma-${version}-nomaps.zip";
    sha256 = "sha256-mW5XDIpwAKV05SXcSMeLtQgNPM2EyLQUh7qqcejUavw=";
  };
  maps = fetchzip {
    url = "https://cdn.playmorepromode.com/files/cpma-mappack-full.zip";
    sha256 = "sha256-gCrZ7GX149sDvqF7hWG4u1dny1mOdC/2iTRplUxw5Sk=";
    stripRoot = false;
  };
  engine = fetchzip {
    url = "https://cdn.playmorepromode.com/files/cnq3/cnq3-${version}.zip";
    sha256 = "sha256-a+9vEFO00vj28KXe/5OGK39SulS+opWCKf47Bb84Swo=";
    stripRoot = false;
  };
in
stdenv.mkDerivation rec {
  inherit version;
  pname = "cpma";

  src = engine;

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];
  buildInputs = [ curl libGL libX11 libXxf86dga alsa-lib libXrandr libXxf86vm libXext SDL2 glibc ];

  installPhase = ''
    mkdir $out
    mkdir $out/lib
    mkdir $out/lib/baseq3
    cp -r ${engine}/cnq3-x64 $out/lib
    chmod +x $out/lib/cnq3-x64
    ls -lah $out/lib/cnq3-x64
    mkdir $out/lib/cpma
    cp -r ${mod}/* $out/lib/cpma
    cp -r ${maps}/* $out/lib/baseq3
    cp -r ${q3-files}/baseq3/*.pk3 $out/lib/baseq3
    makeWrapper $out/lib/cnq3-x64 $out/bin/cnq3-x64 \
      --add-flags "+set fs_homepath $out/lib/" \
      --add-flags "+set com_skipIdLogo 1" \
      --add-flags "+set fs_game cpma"
  '';

  meta = with lib; {
    homepage = "https://www.playmorepromode.com/";
    description = "Quake3e with the CPMA mod.";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ ];
    badPlatforms = [ platforms.aarch64 ];
    # never built on aarch64-linux since first introduction in nixpkgs
    broken = stdenv.isLinux && stdenv.isAarch64;
  };
}

