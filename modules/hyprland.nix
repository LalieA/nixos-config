{ pkgs, config, ... }:

{
    services = {
        # Enable the windowing system
        xserver = {
            enable = true;
            xkb.variant = "azerty";
            xkb.layout = "fr";
        };
        displayManager = {
            defaultSession = "hyprland";
            # Enable the GNOME Display Manager
            gdm = {
                enable = true;
                wayland = true;
            };
        };

        # Enable dbus
        dbus.enable = true;
    };

    # Configure console keymap
    console.keyMap = "fr";

    # Enable the Hyprland Wayland compositor
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
        # XDG Desktop Portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk

        # Hyprpaper (wallpaper)
        hyprpaper

        # SwayNC (notifications)
        swaynotificationcenter

        # SwayLock (lock screen)
        swaylock-effects

        # SwayIDLE (idle manager)
        swayidle

        # xrdb (configure xorg apps)
        xorg.xrdb

        # wayland support
        qt5.qtwayland
        qt6.qtwayland

        # inputs
        libinput
        wev
    ];

    # Enable GTK and use XDG portal for more compatibility
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
        ];
        configPackages = [ config.programs.hyprland.package ];
        config.hyprland = {
            default = [ "hyprland" "gtk" ];
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
            "org.freedesktop.impl.portal.Print" = "gtk";
        };
    };

    # Allow swaylock to unlock user session
    security.pam.services.swaylock = {};

    # Run Electron-based apps under Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
