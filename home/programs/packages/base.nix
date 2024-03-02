{ pkgs, ... }:
let
    basePackages = with pkgs; [
        # archives
        unzip
        zip
        rar

        # clipboard & screenshot
        wl-clipboard
        grim
        slurp
        swappy

        # files
        pcmanfm
        file
        tree
        exiftool

        # network
        networkmanagerapplet
        dig

        # sound
        pavucontrol

        # storage
        gparted
        gptfdisk
        testdisk

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

        # web
        curl
        wget
    ];
in {
    home.packages = basePackages;
}
