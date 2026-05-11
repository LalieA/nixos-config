{ pkgs, ... }:
let
    miscPackages = with pkgs; [
        # Productivity
        zotero

        # 3D
        sweethome3d.application
        sweethome3d.textures-editor
        sweethome3d.furniture-editor
    ];
in {
    home.packages = miscPackages;
}
