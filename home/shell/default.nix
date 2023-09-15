{ ... }:

{
    imports = [
        ./terminals
        ./zsh.nix
    ];

    home.sessionVariables = {
        EDITOR = "code";
        BROWSER = "firefox";
        TERM = "xterm-kitty";

        NIXOS_OZONE_WL = "1"; # Run Electron-based apps under Wayland
    };
}
