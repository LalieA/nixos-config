{ pkgs, ... }:

{
    # Enable OpenGL as required by Hyprland
    hardware.opengl.enable = true;

    services = {
        # Enable the windowing system
        xserver = {
            enable = true;
            layout = "fr";
            xkbVariant = "azerty";

            # Enable the GNOME Display Manager
            displayManager = {
                defaultSession = "hyprland";
                gdm = {
                    enable = true;
                    wayland = true;
                };
            };
        };

        # Enable dbus
        dbus.enable = true;
    };

    # Configure console keymap
    console.keyMap = "fr";

    programs = {
        # Enable the Hyprland Wayland compositor
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };

        # Enable the Waybar bar
        waybar = {
            enable = true;
            package = pkgs.waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        };
    };

    environment.systemPackages = with pkgs; [
        # XDG Desktop Portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk

        # Hyprpaper (wallpaper)
        hyprpaper

        # PulseAudio
        pulseaudio
        wireplumber

        # complementary
        swayidle
        swaylock
        swaybg

        # wayland support
        qt5.qtwayland
        qt6.qtwayland

        # screen
        brightnessctl

        # inputs
        libinput
        wev
    ];

    # Enable GTK and use XDG portal for more compatibility
    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # Allow swaylock to unlock user session
    security.pam.services.swaylock = {};
}
