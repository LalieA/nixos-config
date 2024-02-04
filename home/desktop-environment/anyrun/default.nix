{ pkgs, inputs, ... }:
let
    anyrunPkgs = inputs.anyrun.packages.${pkgs.system};
in
{
    imports = [
        inputs.anyrun.homeManagerModules.default
    ];

    programs.anyrun = {
        enable = true;
        config = {
            plugins = with anyrunPkgs; [
                applications
                kidex
                rink
                translate
            ];
            closeOnClick = true;
            layer = "overlay";
            hidePluginInfo = true;
            showResultsImmediately = true;
            maxEntries = null;
            width = { fraction = 0.3; };
        };
        extraCss = ''
            #window {
                background-color: rgba(255, 255, 255, 0.3);
            }

            box#main {
                background-color: transparent;
            }
            '';
    };
}
