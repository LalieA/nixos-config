{ config, pkgs, lib, ... }:

{
    imports = [
        ./shell
        ./programs
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "23.05";
    };

    # Wallpaper
    dconf.settings = with lib.hm.gvariant; {
        "org/gnome/desktop/background" = {
            color-shading-type = "solid";
            picture-options = "zoom";
            picture-uri = "file://" + ./wallpaper.jpg;
        };
    };

    programs.home-manager.enable = true;
}
