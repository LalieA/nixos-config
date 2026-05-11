{ pkgs, ... }:
let
    desktopPackages = with pkgs; [
        # audio
        audacity
        ffmpeg_6-full

        # documents & notes
        libreoffice-qt
        hunspell
        hunspellDicts.en-us
        hunspellDicts.fr-any
        obsidian

        # files
        nautilus

        # graphism
        gimp

        # keyboard & screen
        qmk
        openrgb
        displaylink

        # messaging
        discord
        signal-desktop

        # OCR
        tesseract4

        # VPN
        protonvpn-gui
    ];
in {
    home.packages = desktopPackages;
}
