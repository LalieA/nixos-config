{ pkgs, ... }:

{
    home.packages = with pkgs; [
        # archives
        unzip
        zip

        # file browsing
        pcmanfm

        # messaging
        discord
        signal-desktop

        # network
        nmap

        # storage
        gparted

        # productivity
        obsidian

        # researches
        zotero

        # programming
        gcc

        python3

        rustc
        cargo
        rustfmt

        shellcheck
        shfmt

        # serial
        minicom

        # system
        htop
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
    services.udiskie = {
        enable = true;
        notify = true;
    };
}
