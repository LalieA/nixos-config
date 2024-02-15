{ pkgs, ... }:
let
    miscPackages = with pkgs; [
        # productivity
        obsidian
        zotero
    ];
in {
    home.packages = miscPackages;
}
