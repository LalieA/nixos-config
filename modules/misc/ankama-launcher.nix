{ pkgs, ... }:

let
  name = "ankama-launcher";
  src = pkgs.fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage";
    sha256 = "06yri31m2k47xhbhalz16mbigmpxrl8dy3k0si8l9mkdyhpa0wpj"; # Change for the sha256 you get after running nix-prefetch-url https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage
 };
 appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };

in

pkgs.appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
    sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
    install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
  '';

  extraPkgs = pkgs: [
      pkgs.wine-staging
  ];
}
