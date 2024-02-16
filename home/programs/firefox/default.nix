{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-wayland;
        profiles = {
            default = {
                id = 0;
                search.force = true;
                settings = builtins.fromJSON (builtins.readFile ./user.js);
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                    noscript
                    privacy-badger
                    skip-redirect
                    ublock-origin
                ];
            };
        };
    };

    home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
    };
}
