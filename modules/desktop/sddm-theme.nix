# sddm-theme-nix
{ pkgs }:

# let
#     imgLink = "<https>";
#     image = pkgs.fetchurl {
#         url = imgLink;
#         sha256 = "";
#     };
# in
pkgs.stdenv.mkDerivation {
    name = "sddm-theme";
    # src = pkgs.fetchFromGitHub {
    #     owner = "MarianArlt";
    #     repo = "kde-plasma-chili";
    #     rev = "a371123959676f608f01421398f7400a2f01ae06";
    #     sha256 = "sha256-fWRf96CPRQ2FRkSDtD+N/baZv+HZPO48CfU5Subt854=";
    # };

    # if fetchFromGitLab is used,the real url's format must like "gitlab.com/owner/repo"
    src = pkgs.fetchgit {
        url = "https://framagit.org/MarianArlt/sddm-sugar-candy.git";
        rev = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";
        sha256 = "1db4p2d0k5a6avr7dg9h1r7y9mx711ci5dgwmljqjb8pq5b0a22y";
    };
    installPhase = ''
        mkdir -p $out
        cp -R ./* $out/
    '';
        # the following are commented
        # cd $out/
        # rm Background.jpg
        # cp -r ${image} $out/Background.jpg
}
