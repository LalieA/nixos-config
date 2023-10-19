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

        # PulseAudio
        pulseaudio
        wireplumber

        # Authentication agent
        polkit_gnome
        at-spi2-core

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

    # Enable polkit and authentication agent
    security.polkit.enable = true;
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical.target" ];
            wants = [ "graphical.target" ];
            after = [ "graphical.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };
}
