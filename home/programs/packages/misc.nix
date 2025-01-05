{ pkgs, ... }:
let
    miscPackages = with pkgs; [
        # productivity
        obsidian
        zotero

        # 3d
        sweethome3d.application
        sweethome3d.textures-editor
        sweethome3d.furniture-editor
    ];
in {
    home.packages = miscPackages;
}
