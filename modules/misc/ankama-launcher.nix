{ pkgs, ... }:

with pkgs;
let
  name = "ankama-launcher";
  src = pkgs.fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage";
    sha256 = "1z0kw788hlgz6jfc660d5ldqd6sa9dfcpp68krqzl8qqnhba7h5j"; # Change for the sha256 you get after running nix-prefetch-url https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage
 };
 appimageContents = appimageTools.extractType2 { inherit name src; };

in

pkgs.appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
    sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
    install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
  '';
}
