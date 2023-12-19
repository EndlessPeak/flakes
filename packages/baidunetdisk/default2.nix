{   stdenv,
    fetchurl,
    pkgs,
    autoPatchelfHook,
    makeWrapper,
    writeText,
    lib,
    ...
} @ args:
let
    libraries = 
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
        ]);
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
in
stdenv.mkDerivation rec{
    pname = "baidunetdisk";
    version = "4.17.7";

    src = fetchurl{
        url = "http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${version}/baidunetdisk_${version}_amd64.deb";
        sha256 = "sha256-UOwY8FYmoT9X7wNGMEFtSBaCvBAYU58zOX1ccbxlOz0=";
    };

    nativeBuildInputs = [ autoPatchelfHook  makeWrapper ];
    buildInputs = libraries;
    
    unpackPhase = ''
        ar x ${src}
        tar xf data.tar.xz
    '';

    installPhase = ''
        mkdir -p $out
        cp -r usr/* $out
        cp -r opt $out/
        rm $out/share/applications/${pname}.desktop
        install -Dm644 ${desktopFile} $out/share/applications/${pname}.desktop
        chmod 644 $out/opt/${pname}/*.so
        makeWrapper $out/opt/${pname}/${pname} $out/bin/${pname} \
            --argv0 "baidunetdisk" \
            --prefix LD_LIBRARY_PATH : "$out/opt/${pname}:${lib.makeLibraryPath libraries}" \
            --run "echo $out"
    '';

    meta = with lib;{
        description = "Baidu Net disk";
        homepage = "https://pan.baidu.com/";
        platforms = ["x86_64-linux"];
    };
}
