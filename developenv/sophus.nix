{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgs
, ... 
}:

stdenv.mkDerivation rec {
  pname = "sophus";
  version = "1.22.10";

  src = fetchFromGitHub {
    owner = "strasdat";
    repo = "Sophus";
    rev = "d270df2be6e46501b1e7efc09b107517e0be0645";
    sha256 = "sha256-t0PkXdXO+2PChlsMeKK3IPxudurqrDD4oOllNKphglk=";
  };

  buildInputs = with pkgs;[
    eigen
    fmt
  ];
  
  nativeBuildInputs = [ cmake ];
  cmakeFlags = [
    "-DBUILD_SOPHUS_TESTS=OFF"
    "-DBUILD_SOPHUS_EXAMPLES=OFF" 
  ];
  meta = with lib; {
    homepage = "https://strasdat.github.io/Sophus";
    description = "C++ implementation of Lie groups commonly used for 2d and 3d geometric problems";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ sander raskin ];
    platforms = platforms.unix;
  };
}
