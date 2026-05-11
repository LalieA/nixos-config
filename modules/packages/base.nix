{ pkgs, ... }:
let
    basePackages = with pkgs; [
        ## archives
        unzip
        zip
        rar

        ## files
        file
        tree
        exiftool

        ## network
        dig
        sshpass
        openvpn
        openconnect

        # storage
        gparted
        gptfdisk
        testdisk
        smartmontools

        # system
        htop
        btop
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
        ungoogled-chromium
    ];
in {
    home.packages = basePackages;
}
