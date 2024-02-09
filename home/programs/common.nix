{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ### Useful ###
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

        # network
        networkmanagerapplet
        nmap
        wireshark

        # sound
        pavucontrol

        # storage
        gparted

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

        ### Miscellaneous ###
        # productivity
        obsidian
        zotero
        tesseract4

        # graphism
        gimp

        # messaging
        discord
        signal-desktop

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

    # Auto-mount USB drives
    services.udiskie = {
        enable = true;
        notify = true;
    };

    # Swappy configuration (screenshots)
    home.file.".config/swappy/config".source = ./swappy.conf;
}
