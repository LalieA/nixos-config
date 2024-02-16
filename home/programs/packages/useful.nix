{ pkgs, pkgs-unstable, ... }:
let
    usefulPackages = with pkgs; [
        # graphism
        gimp

        # messaging
        discord
        signal-desktop

        # OCR
        tesseract4

        # VPN - from unstable because of https://github.com/NixOS/nixpkgs/issues/128114
        pkgs-unstable.protonvpn-gui
    ];
in {
    home.packages = usefulPackages;
}
