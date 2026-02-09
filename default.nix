# Nix expression for VMK - Vietnamese Input Method for Fcitx5
# Based on: https://github.com/thanhpy2009/VMK
{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  extra-cmake-modules,
  fcitx5,
  go,
  libX11,
  libXext,
  libpthreadstubs,
}:
stdenv.mkDerivation rec {
  pname = "fcitx5-vmk";
  version = "0.9.31";

  src = ./src;

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    go
  ];

  buildInputs = [
    fcitx5
    libX11
    libXext
    libpthreadstubs
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
  ];

  # Fix: Go build needs to find bamboo-core source
  preConfigure = ''
    export HOME=$TMPDIR
    export GOPATH=$TMPDIR/go
    export GOCACHE=$TMPDIR/go-cache

    # Fix: Remove Pthread find_package (included in glibc)
    sed -i 's/find_package(Pthread REQUIRED)/# find_package(Pthread REQUIRED)/' CMakeLists.txt
    sed -i 's/Pthread::Pthread/pthread/' src/CMakeLists.txt

    # Fix: Copy vmk.conf directly instead of using fcitx5_translate_desktop_file
    sed -i 's/fcitx5_translate_desktop_file(vmk.conf.in vmk.conf)/configure_file(vmk.conf.in vmk.conf COPYONLY)/' src/CMakeLists.txt

    # Fix: Copy addon conf directly
    sed -i 's/fcitx5_translate_desktop_file.*vmk-addon.conf.in.*vmk-addon.conf.*/configure_file(vmk-addon.conf.in.in vmk-addon.conf)/' src/CMakeLists.txt
  '';

  meta = with lib; {
    description = "Vietnamese Input Method for Fcitx5 with non-preedit mode";
    longDescription = ''
      VMK (Vietnamese Micro Key) is a Vietnamese input method for Fcitx5,
      designed to provide a non-preedit (no underline) typing experience
      similar to UniKey on Windows.
    '';
    homepage = "https://github.com/thanhpy2009/VMK";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [];
  };
}
