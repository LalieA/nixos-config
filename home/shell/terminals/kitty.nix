{ ... }:

{
    programs.kitty = {
        enable = true;
        theme = "Afterglow";
        shellIntegration.enableZshIntegration = true;
        settings = {
            "linux_display_server" = "x11";
            "confirm_os_window_close" = 0;
        };
    };
}
