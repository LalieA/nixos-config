{ pkgs, ... }:
let
    devPackages = with pkgs; [
        # network
        nmap
        wireshark
        snort

        # programming
        gcc
        python3
        rustup
        shellcheck
        shfmt

        # serial
        minicom

        # virtualization
        docker
    ];
in {
    home.packages = devPackages;
}
