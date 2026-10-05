{ ... }:

{
    programs.kitty = {
        enable = true;
        themeFile = "Afterglow";
        shellIntegration.enableZshIntegration = true;
        settings = {
            "linux_display_server" = "wayland";
            "confirm_os_window_close" = 0;
        };
        extraConfig = ''
            # Delete last word
            map ctrl+backspace send_text all \x17

            # Delete next word
            map ctrl+delete send_text all \x1bd
        '';
    };

    home.sessionVariables = {
        KITTY_ENABLE_WAYLAND = "1";
    };
}
