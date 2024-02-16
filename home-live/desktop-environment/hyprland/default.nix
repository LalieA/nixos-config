{ lib, ... }:

{
    imports = [
        ../../../home/desktop-environment/hyprland
    ];

    # Hyprland configuration file
    home.file.".config/hypr/hyprland.conf".source = lib.mkForce ./hyprland.conf;

    # Wallpaper
    home.file.".config/hypr/wallpaper.jpg".source = lib.mkForce ../wallpaper.jpg;
}
