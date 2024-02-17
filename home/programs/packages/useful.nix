{ pkgs, pkgs-unstable, ... }:
let
    usefulPackages = with pkgs; [
        # audio
        audacity
        ffmpeg_6-full

        # graphism
        gimp

        # email
        thunderbird

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
