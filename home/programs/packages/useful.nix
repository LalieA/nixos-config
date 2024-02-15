{ pkgs, ... }:
let
    usefulPackages = with pkgs; [
        # graphism
        gimp

        # messaging
        discord
        signal-desktop

        # OCR
        tesseract4
    ];
in {
    home.packages = usefulPackages;
}
