{ stdenv, lib, buildFHSUserEnv, autoPatchelfHook, unzip, dpkg, gtk3,
  cairo, glib, webkitgtk, libusb1, bash, libsecret, alsa-lib, bzip2,
  openssl, udev, ncurses5, tlf, xorg, fontconfig, pcsclite, python3, ...
}:
let
  makeself-pkg = stdenv.mkDerivation {
    name = "stm32cubeide-makeself-pkg";
    src = ./en.st-stm32cubeide_1.13.0_17399_20230707_0829_amd64.sh.zip;
    unpackCmd = "mkdir tmp && ${unzip}/bin/unzip -d tmp $src";
    installPhase = ''
      sh st-stm32cubeide_1.13.0_17399_20230707_0829_amd64.sh --target $out --noexec
    '';
  };

  stm32cubeide = stdenv.mkDerivation {
    name = "stm32cubeide";
    version = "1.13.0";
    src = "${makeself-pkg}/st-stm32cubeide_1.13.0_17399_20230707_0829_amd64.tar.gz";
    dontUnpack = true;
    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [
      stdenv.cc.cc.lib # libstdc++.so.6
      libsecret
      alsa-lib
      bzip2
      openssl
      udev
      ncurses5
      tlf
      fontconfig
      pcsclite
      python3
    ] ++ (with xorg; [
      libX11
      libSM
      libICE
      libXrender
      libXrandr
      libXfixes
      libXcursor
      libXext
      libXtst
      libXi
    ]);
    autoPatchelfIgnoreMissingDeps = true; # libcrypto.so.1.0.0
    preferLocalBuild = true;
    installPhase = ''
      mkdir -p $out
      tar zxf $src -C $out
    '';
  };
  stlink-server = stdenv.mkDerivation {
    name = "stlink-server-2.1.1-1";
    src = "${makeself-pkg}/st-stlink-server.2.1.1-1-linux-amd64.install.sh";
    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [ libusb1 ];
    unpackCmd = "sh $src --target dir --noexec";

    installPhase = ''
      ls -lR
      mkdir -p $out/bin
      cp stlink-server $out/bin
    '';
  };
in
buildFHSUserEnv {
  name = "stm32cubeide";

  targetPkgs = pkgs: with pkgs; [
    stm32cubeide
    gtk3 cairo glib webkitgtk

    stdenv.cc.cc.lib # libstdc++.so.6
    libsecret
    alsa-lib
    bzip2
    openssl
    udev
    ncurses5
    tlf
    fontconfig
    pcsclite
    python3

    stlink-server
    ncurses5
  ];

  runScript = ''
    ${stm32cubeide}/stm32cubeide
  '';
}
