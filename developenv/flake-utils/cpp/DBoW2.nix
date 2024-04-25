{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgs
, opencvGtk # pass by flake.nix
, ...
}:

stdenv.mkDerivation rec {
  pname = "DBoW2";
  version = "20200301";

  src = fetchFromGitHub {
    owner = "shinsumicco";
    repo = "DBoW2";
    rev = "e8cc74d24705d0ad61b68df4e1086d1deff67136";
    sha256 = "sha256-fG1MEHH7frhRA144g1E/6UluuJsNl1d/V9iqQM0a2HE=";
  };

  buildInputs = with pkgs;[
    opencvGtk
    eigen
  ];

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [
    "-DBUILD_Demo=OFF"
  ];
  meta = with lib; {
    homepage = "https://github.com/shinsumicco/DBoW2";
    description = "Enhanced hierarchical bag-of-word library for C++ (modified to read/write in binary format)";
    # license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ leesin ];
    platforms = platforms.unix;
  };
}
