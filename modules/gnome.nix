{ ... }:

{
    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        layout = "fr";
        xkbVariant = "azerty";

        # Enable the GNOME Display Manager
        displayManager = {
            gdm.enable = true;

            # Enable automatic login for the user.
            autoLogin.enable = true;
            autoLogin.user = "lalie";
        };

        # Enable the GNOME Desktop Environment
        desktopManager.gnome.enable = true;
    };

    # Configure console keymap
    console.keyMap = "fr";

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
}
