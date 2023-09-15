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
                    ublock-origin
                    skip-redirect
                ];
            };
        };
    };

    home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
    };
}
