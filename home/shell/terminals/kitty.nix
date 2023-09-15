{ ... }:

{
    programs.kitty = {
        enable = true;
        theme = "Afterglow";
        shellIntegration.enableZshIntegration = true;
        settings = {
            "linux_display_server" = "wayland";
            "confirm_os_window_close" = 0;
        };
    };

    home.sessionVariables = {
        KITTY_ENABLE_WAYLAND = "1";
    };
}
