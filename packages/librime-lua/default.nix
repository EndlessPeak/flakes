{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "librime-lua";
  version = "2024-03-08";

  src = fetchFromGitHub {
    owner = "hchunhui";
    repo = "librime-lua";
    rev = "20ddea907e0b0c9c60d1dcb6b102bee38697cb5c";
    hash = "sha256-n+KCu8JmFBGPyfBgeLiFqND3wmQs/4eOZjqTXuaW+hk=";
  };

  patchPhase = ''
    sed -i '21i #include <boost/filesystem/path.hpp>\nusing namespace boost::filesystem;' src/opencc.cc
  '';

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out
  '';

  meta = {
    description = "Extending RIME with Lua scripts";
    homepage = "https://github.com/hchunhui/librime-lua";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ zendo ];
  };
})
