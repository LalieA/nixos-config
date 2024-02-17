{ pkgs, ... }:
let
    # Inspired from https://tails.net/doc/about/features/index.en.html
    tailsPackages = with pkgs; [
        # password manager
        keepassxc

        # network
        tor-browser-bundle-bin
        onioncircuits

        # file transfer
        onionshare-gui

        # messaging
        pidgin-with-plugins
        gajim
    ];
in {
    home.packages = tailsPackages;
}
