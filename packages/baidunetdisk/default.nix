{   stdenv,
    fetchurl,
    dpkg,
    buildFHSUserEnv, 
    pkgs,
    makeWrapper,
    writeText,
    ...
}:
let
    baidunetdisk = stdenv.mkDerivation rec {
        pname = "baidunetdisk";
        version = "4.17.7";

        src = fetchurl{
            url = "http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${version}/baidunetdisk_${version}_amd64.deb";
            sha256 = "sha256-UOwY8FYmoT9X7wNGMEFtSBaCvBAYU58zOX1ccbxlOz0=";
        };
        nativeBuildInputs = [ dpkg  makeWrapper ];
        unpackPhase = "dpkg-deb -x ${src} .";

        # 菜单项
        desktopFile = writeText "baidunetdisk.desktop" ''
            [Desktop Entry]
            Name=baidunetdisk
            Name[zh_CN]=百度网盘
            Name[zh_TW]=百度网盘
            Exec=baidunetdisk --no-sandbox %U
            Terminal=false
            Type=Application
            Icon=baidunetdisk
            StartupWMClass=baidunetdisk
            Comment=百度网盘
            Comment[zh_CN]=百度网盘
            Comment[zh_TW]=百度网盘
            MimeType=x-scheme-handler/baiduyunguanjia;
            Categories=Network;
        '';

        installPhase = ''
            mkdir -p $out/opt/${pname}
            mkdir -p $out/share
            mkdir -p $out/bin
            cp -r ./usr/share/* $out/share
            rm $out/share/applications/${pname}.desktop
            install -Dm644 ${desktopFile} $out/share/applications/${pname}.desktop
            cp -r ./opt/${pname}/* $out/opt/${pname}
            chmod 644 $out/opt/${pname}/*.so
            makeWrapper $out/opt/${pname}/${pname} $out/bin/${pname} --set LD_LIBRARY_PATH $out/opt/${pname} --run "echo $out"
        '';
};
in
buildFHSUserEnv {
    name = "${baidunetdisk.pname}";
    targetPkgs = pkgs:
        (with pkgs.xorg; [
            libX11
            libxcb
            libXcomposite
            libXcursor
            libXdamage
            libXext
            libXfixes
            libXi
            libXrandr
            libXrender
            libXScrnSaver
            libXtst ]) ++
        (with pkgs; [
            nss
            nspr
            atk
            alsa-lib
            cups
            at-spi2-atk
            dbus
            glib
            gdk-pixbuf
            gtk3-x11
            pango
            cairo 
            expat
            libdrm
            libxkbcommon
            libGL
            stdenv.cc.cc.lib
            mesa
            libudev0-shim
        ]) ++
        (with pkgs; [ ]) ++ [baidunetdisk];
    runScript = "/bin/${baidunetdisk.pname}";

}
