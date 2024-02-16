{ pkgs, ... }:

{
    programs.librewolf = {
        enable = true;
        package = pkgs.librewolf-wayland;
    };

    home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
    };
}
