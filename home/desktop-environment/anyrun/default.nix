{ pkgs, ... }:

{
    programs.anyrun = {
        enable = true;
        config = {
            plugins = [
                "${pkgs.anyrun}/lib/libapplications.so"
                "${pkgs.anyrun}/lib/libkidex.so"
                "${pkgs.anyrun}/lib/librink.so"
                "${pkgs.anyrun}/lib/libtranslate.so"
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
