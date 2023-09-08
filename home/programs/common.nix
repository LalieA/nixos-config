{ pkgs, ... }:

{
    home.packages = with pkgs; [
        # archives
        unzip
        zip

        # messaging
        discord
        signal-desktop

        # network
        nmap

        # programming
        gcc
        python3
        rustc
        shellcheck
        shfmt

        # serial
        minicom

        # system
        dmidecode
        ethtool
        lm_sensors
        pciutils
        usbutils

        lsof
        ltrace
        strace

        # virtualization
        docker

        # web
        curl
        wget
    ];

    # Auto-mount USB drives
    services.udiskie.enable = true;
}