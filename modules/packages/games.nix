{ pkgs, ... }:
let
    dofus = import ../misc/ankama-launcher.nix {inherit pkgs;};
    gamePackages = with pkgs; [
        # Gaming
        wine-staging
        vulkan-tools
        (lutris.override {
            extraLibraries =  pkgs: [ cdrdao dosbox ];
        })

        # Ankama-Launcher / Dofus
        dofus
    ];
in {
    home.packages = gamePackages;
}
