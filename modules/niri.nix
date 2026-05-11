{ pkgs, lib, config, ... }:

{
    services = {
        dbus = {
            enable = true;
            packages = with pkgs; [
                networkmanager-openvpn
                networkmanager-openconnect
            ];
        };
        libinput.enable = true;
        flatpak.enable = true;
        displayManager = {
            defaultSession = lib.mkForce "niri";
            gdm = {
                enable = true;
                wayland = true;
            };
        };
        xserver = {
            updateDbusEnvironment = true;
            # displayManager = {
            #     sessionCommands = ''
            #         export SSH_AUTH_SOCK
            #     '';
            # };
        };
    };

    # Configure console keymap
    console.keyMap = "fr";

    # Enable the Niri Wayland compositor
    ### --> further defined in home-manager profiles
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
        # XDG Desktop Portals
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome

        # xrdb (configure xorg apps)
        xorg.xrdb

        # xwayland
        xwayland-satellite
    ];

    # Enable GTK and use XDG portal for more compatibility
    xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config.common.default = "*";
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-gnome ];
    };

    # Run Electron-based apps under Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
