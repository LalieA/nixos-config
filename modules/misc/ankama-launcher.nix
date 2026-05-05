{ pkgs, ... }:

let
  pname = "ankama-launcher";
  version = "1.0";
  src = pkgs.fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage";
    hash = "sha256-zaAiOEfUo4qCyTW7XO3qaiwnOAiFFvh9fuco5oNBN/4="; # Change for the sha256 you get after running nix-prefetch-url https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage
 };
 appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };

in

pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
    sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
    install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
  '';

  extraPkgs = pkgs: [
    pkgs.wine-staging
  ];
}
