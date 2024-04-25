# sddm-theme-nix
{ pkgs }:

let
  image = pkgs.fetchurl {
    url = "https://z1.ax1x.com/2023/11/18/piNMTFs.jpg";
    sha256 = "02pgyhmm42bdx31yn64vbmyx7cfnn89zswj40rwr32fdgz83bxy7";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  # src = pkgs.fetchFromGitHub {
  #   owner = "MarianArlt";
  #   repo = "kde-plasma-chili";
  #   rev = "a371123959676f608f01421398f7400a2f01ae06";
  #   sha256 = "sha256-fWRf96CPRQ2FRkSDtD+N/baZv+HZPO48CfU5Subt854=";
  # };

  # if fetchFromGitLab is used,the real url's format must like "gitlab.com/owner/repo"
  src = pkgs.fetchFromGitLab {
    domain = "framagit.org";
    owner = "MarianArlt";
    repo = "sddm-sugar-candy";
    #url = "https://framagit.org/MarianArlt/sddm-sugar-candy.git";
    rev = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";
    sha256 = "1db4p2d0k5a6avr7dg9h1r7y9mx711ci5dgwmljqjb8pq5b0a22y";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/ 
    cd $out/Backgrounds
    cp -r ${image} $out/Backgrounds/magenta.jpg
    cd $out
    sed -i 's/Background="Backgrounds\/Mountain.jpg"/Background="Backgrounds\/magenta.jpg"/g' theme.conf

  '';
  # the following are commented
}